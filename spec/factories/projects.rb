Factory.define :project, :class => Project do |f|
  f.name "Hello"
  f.description "Hello"
  f.start Date.today
  f.end Date.today
end