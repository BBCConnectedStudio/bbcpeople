# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
p1 = Person.find_by_name('David Cameron')
unless p1
  Person.create(
    name: 'David Cameron',
    image_uri: 'http://upload.wikimedia.org/wikipedia/commons/thumb/2/21/David_Cameron_official.jpg/200px-David_Cameron_official.jpg',
    xpedia_slug: 'David_Cameron',
    dbpedia_uri: 'http://en.wikipedia.org/wiki/David_Cameron'
  )
end
