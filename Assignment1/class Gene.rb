class Gene
  attr_accessor :gene_id
  attr_accessor :gene_name
  attr_accessor :mutant_phenotype

  
  def initialize(params = {})
    @gene_id = params.fetch(:gene_id, "AT4G36920")
    @gene_name = params.fetch(:gene_name, "ap1")
    @mutant_phenotype = params.fetch(:mutant_phenotype, "a lot of text")
  
    
  end
  
  def correctcode
    match_code = Regexp.new(/[A-Z](\d\d(.\d\d\d){0,5})/) #regular expression to assure the AGI code is correctly written
    unless match_code.match("#{@gene_id}") 
      puts "Error: Your AGI code does not fit the standard, please check for typos"
        
    end
    
        
  end
    
  
end