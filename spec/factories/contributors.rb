# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :contributor do |f|
  f.name "Hugo Henriques Maia Vieira"
  f.sequence(:username) { |n| "contributor#{n}" }
  f.sequence(:email) { |n| "person#{n}@example.com" }
  f.password "123456"
end

