# frozen_string_literal: true

require_relative 'test_helper'

class TestPlLocale < Test::Unit::TestCase
  def setup
    @phone_prefixes = %w[12 13 14 15 16 17 18 22 23 24 25 29 32 33 34 41 42 43 44 46 48 52 54 55 56 58 59 61 62 63 65 67 68 71 74 75 76 77 81 82 83 84 85 86 87 89 91 94 95].sort
    @cell_prefixes = %w[50 51 53 57 60 66 69 72 73 78 79 88].sort
    @previous_locale = Faker::Config.locale
    Faker::Config.locale = :pl
  end

  def teardown
    Faker::Config.locale = @previous_locale
  end

  def test_pl_names
    names = Faker::Base.fetch_all('name.first_name') + Faker::Base.fetch_all('name.last_name')
    names.each { |name| assert_match(/([\wĄąĆćĘęŁłÓóŚśŻżŹź]+\.? ?){2,3}/, name) }
  end

  def test_pl_phone_number
    prefixes = (0..999).map { Faker::PhoneNumber.phone_number[0, 2] }.uniq.sort

    assert_equal @phone_prefixes, prefixes
  end

  def test_pl_cell_phone
    prefixes = (0..999).map { Faker::PhoneNumber.cell_phone[0, 2] }.uniq.sort

    assert_equal @cell_prefixes, prefixes
  end

  def test_pl_address_methods
    assert Faker::Address.country.is_a? String
    assert Faker::Address.state.is_a? String
    assert Faker::Address.state_abbr.is_a? String
    assert Faker::Address.city_name.is_a? String
    assert Faker::Address.country_code.is_a? String
    assert Faker::Address.building_number.is_a? String
    assert Faker::Address.street_prefix.is_a? String
    assert Faker::Address.secondary_address.is_a? String
    assert Faker::Address.postcode.is_a? String
    assert Faker::Address.city.is_a? String
    assert Faker::Address.street_name.is_a? String
    assert Faker::Address.street_address.is_a? String
    assert Faker::Address.default_country.is_a? String
    assert_equal('Polska', Faker::Address.default_country)
  end

  def test_pl_coin_methods
    assert Faker::Coin.flip.is_a? String
  end

  def test_pl_company_methods
    assert Faker::Company.suffix.is_a? String
    assert Faker::Company.buzzwords.is_a? Array
    assert Faker::Company.bs.is_a? String
    assert Faker::Company.name.is_a? String
  end

  def test_pl_internet_methods
    assert Faker::Internet.free_email.is_a? String
    assert Faker::Internet.domain_suffix.is_a? String
  end

  def test_pl_name_methods
    assert Faker::Name.first_name.is_a? String
    assert Faker::Name.last_name.is_a? String
    assert Faker::Name.prefix.is_a? String
    assert Faker::Name.name_with_middle.is_a? String
  end
end
