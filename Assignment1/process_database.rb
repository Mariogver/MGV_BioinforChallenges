
#require all classes needed for this assignment and the Ruby library CSV that will be usaed to open and to write the files. The paths to
#the classes were not written as they were unknown at the time.
require './class NewSeedStocks.rb'
require './class SeedStock.rb'
require './class Hybrid.rb'
require './class Mix.rb'
require './class Gene.rb'
require "csv"

=begin Please note that the files must be writen as arguments in a certain order on the command line
By means of the csv.read, we open the .tsv files in a table format, easier to manage.
Some of those files had certain parts written as string (double comma) which can be hard for csv.read to undestand,
to facilitate the work, I have set the quote beggining char to a Ç that never appears on the text, so the .read does not
interpretate those parts as strings
=end

file = CSV.read(ARGV[1] , :headers => true, :col_sep=> "\t", :quote_char => "Ç")
file2 = CSV.read(ARGV[2],:col_sep=> "\t", :headers=> true)
file3 = CSV.read(ARGV[0] , :headers =>true, col_sep: "\t", quote_char: "Ç")

=begin I have set a beggining loop the size of the files, in order to read all rows from determined columns of the
newformed tables, and translate this infromation into objects of each class (see each class for more details on how they were made)
=end

for i in 0..(file2.size()-1)
 
 object = Seed_Stocks.new(
    :seed_stock => file["Seed_Stock"][i],
    :mutant_gene_ID => file["Mutant_Gene_ID"][i],
    :last_planted => file["Last_Planted"][i],
    :storage => file["Storage"][i],
    :gr_remaining => file["Grams_Remaining"][i])
   object.seedremove(7)
   object.to_tsv(ARGV[3])
   
=begin The first object belongs to the SeedStock table(file), and after is set (created as an object), the method .seedremove is applied
to remove a value of 7 seeds from the stock. If this value happens to be higher than the current stock, a warning
message is printed out. It also creates a new object with the subsequent changes on the stock in a new class
named New_Seed_Stock.
After this, this same object is applied to the method .to_tsv, which creates a tsv file of the new seed stock table (with all the changes
applied). The name of said file can be written as an argument of this method, but instead is taken from the commandline ARGV[3] as asked.
=end
 
   
   object4 = Gene.new(
    :gene_id => file3["Gene_ID"][i],
    :gene_name => file3["Gene_name"][i],
    :mutant_phenotype => file3["mutant_phenotype"][i])
    object4.correctcode
   
=begin This second object (object4) is created from the Gene information table (file3), and is to be a part of the Gene class.
The method correctcode checks for misspellings on the AGI code,and if detected returns a error message
=end

end
   
for i in 0..(file2.size()-1)   #this loop is the same as the first, but I prefer to have them separated for convenience.
  if i<5
  object3 = Mix.new(
    :Gene_name1 => file3["Gene_name"][i],
    :Gene_name2 => file3["Gene_name"][i+1])
  else
    object3 = Mix.new(
      :Gene_name1 => file3["Gene_name"][5],
      :Gene_name2 => file3["Gene_name"][1])
  end
=begin This is a tricky object. It belongs to the class MIx, which is simply a space I created to store the gene names from the
gene information table associated to the parental crosses' gene identifiers. When I looked at the tables I realized that the parental lines on
the cross data table were chosen following an order, the first (of the gene infor table) with the second, the second with the third...except the
last one, which came back to the top. So I just stored these on that particular order on the Mix class with a couple of conditionals to avoid linking the tables.
=end

  object2 = Hybrid.new(
    :Parent1 => file2["Parent1"][i],
    :Parent2 => file2["Parent2"][i],
    :F2_Wild => file2["F2_Wild"][i],
    :F2_P2 => file2["F2_P2"][i],
    :F2_P1 => file2["F2_P1"][i],
    :F2_P1P2 => file2["F2_P1P2"][i],
    :Gene_nameP1 => object3.gene_name1,
    :Gene_nameP2 => object3.gene_name2)
   object2.chisquare
   
=begin Object2 is the last object to be created, and belongs to the Hybrid class. This object calls for the parental gene_names stored on the
object3 as values for the instance attributes. The method .chisquare studies the linkage between genes by menas of a chi square test of
the crosses, and prints the results.
To finish, the Hybrid.linkage class method prints out a final report on the linkage matter, after the loop is completed and all
instances have been examined.
=end
   
end
Hybrid.linkage


