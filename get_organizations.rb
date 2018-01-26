require 'rubygems' if RUBY_VERSION < '1.9'
require 'rest_client'

ids = [92858]

    values = "{
        'query': '{
          organizations
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
                cards_count
                cards
                {
                  edges
                  {
                    cursor
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
                  description
                  required
                  minimal_view
                  options { }
                }
              }
            }
          }
        }'
    }"

    values = values.gsub("\n", ' ').squeeze(' ').gsub('\'','"')

headers = {
  :content_type => 'application/json',
  :authorization => 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1c2VyIjp7ImlkIjo2NjE0MCwiZW1haWwiOiJwaXBlZnlkZXZyZWNydWl0aW5nZmFrZXVzZXJAbWFpbGluYXRvci5jb20iLCJhcHBsaWNhdGlvbiI6NDUzOH19.uUX4KIR4m_K-8NwLYhtVpsNnLEoLARebIQiyQDxEm3RZLHCffLrcH-V8RmuJLu8nqE8AQ-SvqUvgz3fe0UyZ4w'
}

response = RestClient.post 'https://app.pipefy.com/queries', values, headers
puts response
