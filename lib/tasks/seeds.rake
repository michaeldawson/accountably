namespace :dump do
  task seeds: :environment do
    File.open('db/seeds.rb', 'wb') do |file|
      file.write ERB.new(File.read('lib/tasks/seeds/template.erb')).result(binding)
    end
  end
end
