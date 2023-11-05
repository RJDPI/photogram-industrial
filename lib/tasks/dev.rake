# desc "Fill the database tables with some sample data"
# task({ :sample_data => :environment }) do
# end
task sample_data: :environment do
  p "Creating sample data"
end
