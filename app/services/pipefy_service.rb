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
    select_ids = ids.present? ? "(ids: #{ids})" : nil

    values = "{
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

    values = values.tr("\n", ' ').squeeze(' ').tr('\'', '"')
    response = RestClient.post("#{@url}/queries", values, @headers)
    response = JSON.parse(response.body)
    response['data']['organizations']
  end
end
