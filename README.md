# Appilf (╯°□°）╯︵ ┻━┻

[![Build Status](https://travis-ci.org/rogeliosevilla1/appilf.svg?branch=master)](https://travis-ci.org/rogeliosevilla1/appilf)

[![Coverage Status](https://coveralls.io/repos/github/rogeliosevilla1/appilf/badge.svg?branch=master)](https://coveralls.io/github/rogeliosevilla1/appilf?branch=master)

Appilf is a simple Ruby wrapper for Flippa's API (https://developers.flippa.com/),

##Installing

Install via Rubygems

```
gem install appilf
```

Or through your Gemfile

```
gem "appilf", "~> 0.1"
```


##Overview
Appilf currently covers the following resources:


###Authentication not required

 * Listings

###Authentication required

 * Users
 * Domain Traits
 * Alerts
 * Saved Searches
 * Watched Items


##Authentication

As of now, Appilf only supports authentication through Password Grant
(https://developers.flippa.com/#client-credentials-grant).  There are 2 ways to initialize the client:

```ruby
client = Appilf::Client.new(username: 'fat@dog.com', password: 'some_password')
client.access_token  => 'token used to make authorized requests'
```

If you already have a token...

```ruby
client = Appilf::Client.new(access_token: 'sometoken')
```


##Paginated Resources

When calling a resource paginated by Flippa, Appilf will return an instance of `Appilf::ResourcePage`.
You can use the `next` and `prev` methods to retrieve another page using the current page as reference.
You can access the loaded items through its `items` array or iterate it directly with `each` (e.g.)

```ruby
 resource_page = Appilf::Listing.list
 resource_page.each do |item|
  item.id
 end
 next_page = resource_page.next
```

The object will return `nil` if you try to navigate to a non existent page.

You can use the `:page_number`  and `:page_size` modifiers when calling a paginated resource
to increase the default page size or to retrieve an specific page. (e.g.)

```ruby
resource_page = Appilf::Listing.list(page_size: 100, page_number: 3)
```

Be aware that Flippa limits all paginated resources to the first 200 pages, after that, you will get
an `Appilf::BadRequest` error (https://developers.flippa.com/#pagination)  (e.g)

```ruby
#this raises an Appilf::BadRequest error
Appilf::Listing.list(page_number: 201)
```


##Listings

Listings are for now the only resource that does not require authentication and it's paginated by
Flippa. You can retrieve the first page of Listings by doing:

```
Appilf::Listing.list
```

###Sorting

Per Flippa's documentation, you can send a query parameter to sort the results...

```
Appilf::Listing.list(sort_alias: 'most active')
```

To see all the supported values please refer to the "SORT ALIAS PARAMETERS" section
 within Flippa's documentation on Listings (https://developers.flippa.com/#list-all-listings)



###Search Templates

Per Flippa's documentation, you can send a query parameter to do a custom search using their
predefined templates.

```
Appilf::Listing.list(search_template: 'apps_ending_soon')
```

To see all the supported values please refer to the "SEARCH TEMPLATES" section
 within Flippa's documentation on Listings (https://developers.flippa.com/#list-all-listings)

###Relationships

Per Flippa's documentation, you can send a query parameter to include additional
Listing relationships, so far only one value is accepted `tags_site_type` , Flippa may
return additional relationships without needing explicit request.

```ruby
listing = Appilf::Listing.list(include: 'tags_site_type').first
listing.seller => Appilf::User
listing.tags_site_type => Array of Appilf::Object
```


##Alerts

You can retrieve the alerts from the authenticated user by using the `list_alerts` method within
an authenticated client. The result is contained within the meta field as returned by Flippa

```ruby
alerts = client.list_alerts
alerts.meta.pending_bids_count
```


##Domain Traits

You can retrieve the domain_traits of a certain listing by using the `list_domain_traits` method
within an authenticated client

```ruby
client.list_domain_traits(some_listing_id) => Array of Appilf::DomainTrait
```


##Users

You can retrieve the current authenticated user by doing

```ruby
client.retrieve_user  => Appilf:User
```

You can also retrieve a different user by specifying an id during the call

```ruby
client.retrieve_user(some_user_id) => Appilf:User
```


##Saved Searches

To retrieve the list of saved searches that belong to the current user, use the
`list_saved_searches` method. (This is a paginated resource) (e.g.)

```ruby
client.list_saved_searches => Appilf:ResourcePage
```

You can also delete a saved search entry by using the `delete_saved_search` method. (e.g.)

```ruby
client.delete_saved_search(saved_search_id) => :success
```


##Watched Items

To create a watched_item, use the `create_watched_item` method, providing the item_type and item_id
arguments. (e.g)

```ruby
client.create_watched_item('listing', 123) => Appilf::WatchedItem
```

You can also delete a watched item through the `delete_watched_item` method
by passing the same arguments as the previous method. (e.g.)

```ruby
client.delete_watched_item('listing', 123) => :success
```


##TODO's
 * Handle pagination correctly for resources that require authentication (affects only Saved Searches for now)
 * Improve the testing suite by adding test cases involving bad requests