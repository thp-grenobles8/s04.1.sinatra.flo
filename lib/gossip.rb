require 'csv'

class Gossip
  attr_accessor :author, :content, :comment
  def initialize(author, content, comment = "['']")
    @author = author
    @content = content
    @comment = comment
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content, @comment]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1], csv_line[2])
    end
    return all_gossips
  end

  def self.find(row)
    gossip = CSV.read("./db/gossip.csv")[row.to_i]
    return gossip
  end

  def self.edit(id,txt_to_edit)
   all_gossips = Gossip.all
   all_gossips[id.to_i].content = txt_to_edit
   CSV.open("./db/gossip.csv", "w") do |csv|
     csv = ""
   end
   all_gossips.each {|gossip| gossip.save}
  end

  def self.add_comment(id, comment)
    all_gossips = Gossip.all
    all_gossips[id.to_i].comment = all_gossips[id.to_i].comment[0..-2] << ", #{comment}]"
    CSV.open("./db/gossip.csv", "w") do |csv|
      csv = ""
    end
    all_gossips.each {|gossip| gossip.save}
  end
end
