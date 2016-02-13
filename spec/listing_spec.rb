require 'spec_helper'

describe Appilf::Listing do
  include Appilf::TestData

  describe '.new' do
    let(:listing) { Appilf::Listing.new(load_test_json_data(mocked_response_file_path('listing/listing.json'))) }

    it 'should respond to id' do
      listing.id.should == "6046240"
    end

    it 'should respond to app_downloads_per_month' do
      listing.app_downloads_per_month.should == nil
    end

    it 'should respond to bid_count' do
      listing.bid_count.should == 0
    end

    it 'should respond to buy_it_now_price' do
      listing.buy_it_now_price.should == nil
    end

    it 'should respond to confidential' do
      listing.confidential.should == false
    end

    it 'should respond to current_price' do
      listing.current_price.should == 50
    end

    it 'should respond to ends_at' do
      listing.ends_at.should == "2016-02-16T07:43:54+11:00"
    end

    it 'should respond to established_at' do
      listing.established_at.should == "2001-01-31T11:00:00+11:00"
    end

    it 'should respond to has_verified_revenue' do
      listing.has_verified_revenue.should == false
    end

    it 'should respond to has_verified_traffic' do
      listing.has_verified_traffic.should == false
    end

    it 'should respond to page_views_per_month' do
      listing.page_views_per_month.should == nil
    end

    it 'should respond to post_auction_negotiable' do
      listing.post_auction_negotiable.should == false
    end

    it 'should respond to post_auction_negotiable' do
      listing.post_auction_negotiable.should == false
    end

    it 'should respond to profit_per_month' do
      listing.profit_per_month.should == 0
    end

    it 'should respond to property_name' do
      listing.property_name.should == "digamatic.com"
    end

    it 'should respond to reserve_met' do
      listing.reserve_met.should == false
    end

    it 'should respond to revenue_per_month' do
      listing.revenue_per_month.should == 0
    end

    it 'should respond to revenue_sources' do
      listing.revenue_sources.should == []
    end

    it 'should respond to sale_method' do
      listing.sale_method.should == 'auction'
    end

    it 'should respond to starts_at' do
      listing.starts_at.should == "2016-02-10T07:43:54+11:00"
    end

    it 'should respond to status' do
      listing.status.should == "open"
    end

    it 'should respond to summary' do
      listing.summary.should == nil
    end

    it 'should respond to title' do
      listing.title.should == 'cool company name !'
    end

    it 'should respond to uniques_per_month' do
      listing.uniques_per_month.should == nil
    end

    it 'should respond to watching' do
      listing.watching.should == false
    end

    it 'should respond to images fields' do
      listing.images.thumbnail.url.should == nil
      listing.images.thumbnail.targets.should == []
    end

    it 'should contain an User within the seller relationship' do
      listing.seller.class.should == Appilf::User
    end

    it 'should contain a link pointing to itself' do
      listing.links.self.should == "https://api.flippa.com/v3/listings/6046240"
    end

  end


  describe '.retrieve' do
    let(:listing) { Appilf::Listing.retrieve(6046240) }
    before { stub_api_get_request(Appilf::Listing.listings_path(6046240), 'listing/listing.json') }

    it 'should return a Listing' do
      listing.class.should == Appilf::Listing
    end
  end

  describe '.list' do

    context 'without arguments' do
      let(:resource_page) { Appilf::Listing.list }
      before { stub_api_get_request(Appilf::Listing.listings_path, 'listing/listing_page_1.json') }

      it 'should be a Appilf::ResourcePage' do
        resource_page.class.should == Appilf::ResourcePage
      end

      it 'should contain 30 entries' do
        resource_page.count.should == 30
      end

      specify 'page meta should contain page_number, page_size, total_results' do
        resource_page.page_meta.page_number.should == 1
        resource_page.page_meta.page_size.should == 30
        resource_page.page_meta.total_results.should == 1657436
      end

      specify 'all entries should be of type Appilf::Listing' do
        resource_page.all?{ |listing| listing.class.should == Appilf::Listing  }.should be_truthy
      end

      context 'navigating to another page' do
        let(:next_page) { resource_page.next }
        before { stub_api_get_request(resource_page.page_links.next, 'listing/listing_page_2.json') }

        it 'should retrieve another page' do
          next_page.class.should == Appilf::ResourcePage
        end

        it 'new page should be the second page' do
          next_page.page_meta.page_number.should == 2
        end
      end

      context 'navigating to non existent page' do
        it 'should raise a NonExistentPage error' do
          expect { resource_page.previous }.to raise_error(Appilf::NonExistentPage)
        end
      end
    end

    context 'with pagination arguments' do
      let(:resource_page) { Appilf::Listing.list(page_number: 5, page_size: 100) }
      before { stub_api_get_request(Appilf::Listing.listings_path, 'listing/listing_page_5.json', 200,
                                    {'page[number]' => 5, 'page[size]' => 100}) }

      it 'should return page 5 with 100 entries' do
        resource_page.page_meta.page_number.should == 5
        resource_page.count.should == 100
      end
    end

  end
end