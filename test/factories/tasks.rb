# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :task do |f|
  f.title "Create issues"
  f.description "Create issues to kanban-roots project"
  f.points 5
  f.category "Feature"
end

