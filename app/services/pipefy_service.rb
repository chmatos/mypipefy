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
    response = RestClient.post("#{@url}/queries", query_organizarions(ids: ids), @headers)
    response = JSON.parse(response.body)
    response['data']['organizations']
  rescue StandardError
    nil
  end

  def store(organizations: nil)
    return if organizations.blank?
    organizations.each do |organization|
      org = Organization.find_or_create_by(id: organization['id'])
      org.update(id: organization['id'], name: organization['name'], created_at: organization['created_at'])
      store_pipes(organization_id: org.id, pipes: organization['pipes'])
    end
  end

  def store_pipes(organization_id:, pipes: nil)
    return if pipes.blank? || organization_id.blank?
    pipes.each do |pipe|
      pip = Pipe.find_or_create_by(id: pipe['id'])
      pip.update(id: pipe['id'], name: pipe['name'], organization_id: organization_id)
      #store_phases(pipe['phases'])
    end
  end

  def query_organizarions(ids: nil)
    select_ids = ids.present? ? "(ids: #{ids})" : nil
    query = "{
        'query': '{
          organizations #{select_ids}
          {
            id
            name
            created_at
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
