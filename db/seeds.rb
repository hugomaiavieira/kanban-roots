# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Project.delete_all
Contributor.delete_all

Contributor.create!(
  :name => 'John Doe',
  :email => 'contributor@example.com',
  :password => '123456',
  :password_confirmation => '123456'
)

Project.create!(
  :name => 'kanban-roots',
  :description => 'A kanban board that keeps the simplicity as well as the roots of the concept.',
  :owner_id => Contributor.all.first.id
)

