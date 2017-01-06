namespace :seeds do
  task dump: :environment do
    File.open('db/seeds.rb', 'wb') do |file|
      file.write ERB.new(File.read('lib/tasks/seeds/template.erb')).result(binding)
    end
  end
end
