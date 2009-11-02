class Document < ActiveRecord::Base
  
  attr_accessor :rdf, :calais_signature

  has_one  :full_text,  :dependent => :destroy
  has_many :pages,      :dependent => :destroy  
  has_many :metadata,   :dependent => :destroy
  
  SEARCHABLE_ATTRIBUTES = [:title, :source]
  
  delegate :text, :to => :full_text
  
  # Main document search method -- handles queries.
  def self.search(query, options={})
    query = DC::Search::Parser.new.parse(query) if query.is_a? String
    query.run
  end
  
  def to_json(opts={})
    attributes.to_json
  end
  
end