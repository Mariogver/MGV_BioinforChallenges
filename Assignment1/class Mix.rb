class Mix
  attr_accessor :gene_name1
  attr_accessor :gene_name2
  
  def initialize(params= {})
    @gene_name1 = params.fetch(:Gene_name1, "name")
    @gene_name2 = params.fetch(:Gene_name2, "name")
  end
end
  
  