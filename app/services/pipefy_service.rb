# frozen_string_literal: true

class PipefyService
  def initialize
    @url = ENV['PIPEFY_URL']
    @headers = {
      content_type: 'application/json',
      authorization: "Bearer #{ENV['PIPEFY_TOKEN']}"
    }
  end

  def fetch_organizations(ids: nil)
    response = RestClient.post("#{@url}/queries", query_organizations(ids: ids), @headers)
    response = JSON.parse(response.body)
    response['data']['organizations']
  rescue StandardError
    nil
  end

  def store(organizations: nil)
    return if organizations.blank?
    organizations.each do |organization|
      org = Organization.find_or_create_by(id: organization['id'])
      org.update(name: organization['name'], created_at: organization['created_at'])
      store_pipes(organization_id: org.id, pipes: organization['pipes'])
    end
  end

  def store_pipes(organization_id:, pipes: nil)
    return if pipes.blank? || organization_id.blank?
    pipes.each do |pipe|
      pip = Pipe.find_or_create_by(id: pipe['id'])
      pip.update(name: pipe['name'], organization_id: organization_id)
      store_phases(phases: pipe['phases'], pipe_id: pip.id)
    end
  end

  def store_phases(phases: nil, pipe_id:)
    return if phases.blank? || pipe_id.blank?
    phases.each do |phase|
      pha = Phase.find_or_create_by(id: phase['id'])
      pha.update(name: phase['name'], pipe_id: pipe_id)
      store_fields(fields: phase['fields'], phase_id: pha.id, card_id: nil)
      store_cards(cards: phase['cards'], phase_id: pha.id)
    end
  end

  def store_fields(fields: nil, phase_id: nil, card_id: nil)
    return if fields.blank? || phase_id.blank?
    fields.each do |field|
      key = card_id.present? ? field['field']['id'] : field['id']
      fie = Field.find_or_create_by(key: key, phase_id: phase_id)
      fie.update(name: field['name'] || field['label'], card_id: card_id) if card_id.blank? || fie.card_id == card_id || fie.name.blank?
      store_value(content: field['value'], key: key, phase_id: phase_id, card_id: card_id) if card_id.present?
    end
  end

  def store_value(content: nil, key: nil, phase_id: nil, card_id: nil)
    return if content.blank? || key.blank? || phase_id.blank? || card_id.blank?
    val = Value.find_or_create_by(key: key, phase_id: phase_id, card_id: card_id)
    val.update(content: content)
  end

  def store_cards(cards: nil, phase_id:)
    return if cards.blank? || phase_id.blank?
    cards['edges'].each do |edge|
      node = edge['node']
      car = Card.find_or_create_by(id: node['id'])
      car.update(
        title: node['title'],
        created_at: node['createdAt'],
        due_date: node['due_date'],
        phase_id: node['current_phase']['id']
      )
      store_fields(fields: node['fields'], phase_id: phase_id, card_id: node['id'])
    end
  end

  def query_organizations(ids: nil)
    select_ids = ids.present? ? "(ids: #{ids})" : nil
    query = "{
        'query': '{
          organizations #{select_ids}
          {
            id
            name
            pipes
            {
              id
              name
              phases
              {
                id
                name
                cards
                {
                  edges
                  {
                    node
                    {
                      id
                      title
                      createdAt
                      due_date
                      current_phase { id }
                      fields
                      {
                        field { id }
                        name
                        value
                      }
                    }
                  }
                }
                fields
                {
                  id
                  label
                }
              }
            }
          }
        }'
    }"
    query.tr("\n", ' ').squeeze(' ').tr('\'', '"')
  end
end
