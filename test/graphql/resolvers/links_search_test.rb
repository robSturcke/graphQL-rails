require 'test_helper'

module Resolvers
  class LinkSearchTest < ActiveSupport::TestCase
    def find(args)
      ::Resolvers::LinksSearch.call(nil, args, nil)
    end

    def create_user
      User.create name: 'test', email: 'test@example.com', password: '123456'
    end

    def create_link(**attributes)
      Link.create! attributes.merge(user: create_user)
    end

    test 'filter option' do
      link1 = create_link description: 'test1', url: 'httL//test1.com'
      link2 = create_link description: 'test2', url: 'httL//test2.com'
      link3 = create_link description: 'test3', url: 'httL//test3.com'
      link4 = create_link description: 'test4', url: 'httL//test4.com'

      result = find(
        filter: {
          description_contains: 'test1',
          OR: [{
            url_contains: 'test2',
            OR: [{
              url_contains: 'test3'
            }]
          }, {
            description_contains: 'test2'
          }]
        }
      )

      assert_equal result.map(&:description).sort, [link1, link2, link3].map(&:description).sort
    end
  end
end