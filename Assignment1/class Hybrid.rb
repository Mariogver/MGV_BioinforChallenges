class Hybrid
  attr_accessor :Parent1
  attr_accessor :Parent2
  attr_accessor :F2_Wild
  attr_accessor :F2_P1
  attr_accessor :F2_P2
  attr_accessor :F2_P1P2
  attr_accessor :Gene_nameP1
  attr_accessor :Gene_nameP2
  
  @@gn1 =[] 
  @@gn2 =[]
 
  
  def initialize(params = {})
    @parent1 = params.fetch(:Parent1, "A348")
    @parent2= params.fetch(:Parent2, "AT4G")
    @f2_wild= params.fetch(:F2_Wild,"34")
    @f2_p1 = params.fetch(:F2_P1, "123")
    @f2_p2 = params.fetch(:F2_P2, "10")
    @f2_p1p2 = params.fetch(:F2_P1P2, "34")
    @gene_namep1 = params.fetch(:Gene_nameP1, "lepe")
    @gene_namep2 = params.fetch(:Gene_nameP2, "lope")
    @@gn1 = @gene_namep1
    @@gn2 = @gene_namep2
    
  end
def chisquare
    a = @f2_wild.to_i
    b = @f2_p1.to_i 
    c = @f2_p2.to_i
    d = @f2_p1p2.to_i
   total = a.to_f+ b.to_f + c.to_f + d.to_f #floats were necessary for correct calculus
   #chi calculations:
    chi = (((a-(total*9/16))**2)/(total*9/16))+(((b-(total*3/16))**2)/(total*3/16))+(((c-(total*3/16))**2)/(total*3/16))+(((d-(total*1/16))**2)/(total*1/16))
  
  if chi.to_f>= 7.815 #this is the standard relevance value for a degree 3 chi square
    puts "Recording: #{@gene_namep1} is genetically linked to #{@gene_namep2} with a chisquare score #{chi}"
    
     @@gn1 = "#{@gene_namep1}"
     @@gn2 = "#{@gene_namep2}"
    
 
  end
end
  
  def Hybrid.linkage
    
    puts "Final report"
    puts "#{@@gn1} is linked to #{@@gn2}"
    puts "#{@@gn2} is linked to #{@@gn1}"
    #for some strange reason, the code does not seem to give a value for @@gn2 (I did the excat same things for @@gn1 and works).
    #I do not know why,I have tried several things but with no use. Anyway that blank space slightly amuses me. 
  end
  
 
  
end
