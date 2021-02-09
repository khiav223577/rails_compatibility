require 'test_helper'
require 'rails_compatibility/build_joins'

class BuildJoinsTest < Minitest::Test
  def setup
    @county_ids = County.all.map{|s| [s.name, s.id] }.to_h
    @zipcode_ids = Zipcode.all.map{|s| [s.zip, s.id] }.to_h
  end

  def test_has_and_belongs_to_many_when_many_models_mapping_to_one
    reflect = County.reflect_on_association(:zipcodes)

    relation = Zipcode.where(zip: '30301')
    relation = relation.joins(RailsCompatibility.build_joins(reflect, relation))
    assert_equal [@county_ids['Fulton']], relation.pluck('counties_zipcodes.county_id')

    relation = Zipcode.where(zip: '30291')
    relation = relation.joins(RailsCompatibility.build_joins(reflect, relation))
    assert_equal [@county_ids['Fulton']], relation.pluck('counties_zipcodes.county_id')

    relation = Zipcode.where(zip: '55410')
    relation = relation.joins(RailsCompatibility.build_joins(reflect, relation))
    assert_equal [@county_ids['Hennepin']], relation.pluck('counties_zipcodes.county_id')

    relation = Zipcode.where(zip: '55416')
    relation = relation.joins(RailsCompatibility.build_joins(reflect, relation))
    assert_equal [@county_ids['Hennepin']], relation.pluck('counties_zipcodes.county_id')

    relation = Zipcode.where(zip: '!INVALID!')
    relation = relation.joins(RailsCompatibility.build_joins(reflect, relation))
    assert_equal [], relation.pluck('counties_zipcodes.county_id')
  end

  def test_has_and_belongs_to_many_when_one_models_mapping_to_many
    reflect = Zipcode.reflect_on_association(:counties)

    relation = County.where(name: 'Fulton')
    relation = relation.joins(RailsCompatibility.build_joins(reflect, relation))
    assert_equal [@zipcode_ids['30301'], @zipcode_ids['30291']], relation.pluck('counties_zipcodes.zipcode_id')

    relation = County.where(name: 'Hennepin')
    relation = relation.joins(RailsCompatibility.build_joins(reflect, relation))
    assert_equal [@zipcode_ids['55410'], @zipcode_ids['55416']], relation.pluck('counties_zipcodes.zipcode_id')

    relation = County.where(name: '!INVALID!')
    relation = relation.joins(RailsCompatibility.build_joins(reflect, relation))
    assert_equal [], relation.pluck('counties_zipcodes.zipcode_id')
  end
end
