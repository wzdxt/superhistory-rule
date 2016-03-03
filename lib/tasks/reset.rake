desc 'reset rules'
task :reset  => :environment do
  p HostRule.reset_table
  p PathRule.reset_table
end