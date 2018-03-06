require 'pry-byebug'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    # source https://stackoverflow.com/questions/13303401/quickly-setting-instance-variables-with-options-hash-in-ruby
    student_hash.each { |k,v| instance_variable_set("@#{k}", v) }
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
     Student.new(student)
    end
    
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each { |k,v| instance_variable_set("@#{k}", v) }
  end

  def self.all
    @@all
  end
end

