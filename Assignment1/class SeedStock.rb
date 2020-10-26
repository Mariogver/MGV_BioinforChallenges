class Seed_Stocks
  attr_accessor :seed_stock
  attr_accessor :mutant_gene_ID
  attr_accessor :last_planted
  attr_accessor :storage
  attr_accessor :gr_remaining
  attr_accessor :date
  
  def initialize(params = {})
    @seed_stock = params.fetch(:seed_stock, "A348")
    @mutant_gene_ID = params.fetch(:mutant_gene_ID, "AT4G36920")
    @last_planted = params.fetch(:last_planted, "3/7/2015")
    @storage = params.fetch(:storage, "cama21")
    @gr_remaining = params.fetch(:gr_remaining, 99)
    @date = "8/2/2015" #I added this because I realized there was a date written on the "your file should look lke this" part of the assignment.
    #could be put as a forth ARGV, makes more sense.
  end
  def seedremove(value)
    if (@gr_remaining.to_i)-value <= 0 # With this conditional I discriminate regular substractions from those in which the value is > grams_remaining
      @zero = 0 #in order to avoid negative numbers @zero is set to 0.
       puts "Warning: we have run out of Seed Stock #{@seed_stock}"
    else
      @zero = @gr_remaining.to_i - value 
      
    end
  new_object = New_Seed_Stocks.new( #creating a new object for the New_Seed_Stock class
    :seed_stock => @seed_stock,
    :mutant_gene_ID => @mutant_gene_ID,
    :last_planted => @date,
    :storage => @storage,
    :gr_remaining => @zero) #this new object has the redefined stock
   
  end
  
  def to_tsv(tsvfilename = "Stockernew.tsv") 
     
   hash = {"seed_stock" => @seed_stock, #as the csv.open method (from the CSV library) is going to be used, I create a hash for easier manipualtion of data)
     "mutant_gene_ID" => @mutant_gene_ID,
     "last_planted" => @date,
     "storage" => @storage,
     "gr_remaining" => @zero} #just like the new object
    #puts hash
      keys = hash.keys
    #puts keys
    CSV.open(tsvfilename, "a",:col_sep=> "\t") do |csv| #the "a" parameter (append) so each line is written under the previous
      firstline = CSV.read(tsvfilename, :headers => false, :col_sep=> "\t", :quote_char => "Ç") 
      if firstline.size() == 0 #this conditional is to write (if they were not already there) the header of the file
          csv << keys
      else
        csv << hash.values_at(*keys)
      end
    end
  end
 
  
end
