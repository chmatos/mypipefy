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
      Organization.store(organization: organization)
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
