# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :project do |f|
  f.name "kanban-roots"
  f.description "A kanban board that keeps the simplicity."
  f.association :owner, :factory => :contributor
end

