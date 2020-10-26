class New_Seed_Stocks
  attr_accessor :seed_stock
  attr_accessor :mutant_gene_ID
  attr_accessor :last_planted
  attr_accessor :storage
  attr_accessor :gr_remaining
  attr_accessor :hash
  attr_accessor :keys

  
  def initialize(params = {})
    @seed_stock = params.fetch(:seed_stock, "A348")
    @mutant_gene_ID = params.fetch(:mutant_gene_ID, "AT4G36920")
    @last_planted = params.fetch(:last_planted, "3/7/2015")
    @storage = params.fetch(:storage, "cama21")
    @gr_remaining = params.fetch(:gr_remaining, 99)
  end
  
 
    
    
end