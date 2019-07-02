include Rails.application.routes.url_helpers
require 'aws-sdk'

desc 'Looks for recent memes with a certain number of reports and analyze them!'
namespace :db do
  task :explicit_image => :environment do
    client = Aws::Rekognition::Client.new(
      region: ENV['AWS_REGION'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    )  
    memes = Meme.with_attached_image.where("report >= 2")
    
    memes.each{|meme|
      puts("Meme id: #{meme.id}")
      if Rails.env.production?
        #env production not tested yet
        uri = meme.image.service_url
        dir = uri.split("/").fourth
        key = dir.split("?").first
        @params={
          image: {s3_object: {bucket: ENV['AWS_BUCKET'],name: @key}},min_confidence: 70}
      else
        local_route = ActiveStorage::Blob.service.send(:path_for,meme.image.key)
        @params = {
          image: {bytes: File.read(local_route)},
          min_confidence: 70
        }
      end
      response = client.detect_moderation_labels(@params)
      flag = false
      response.moderation_labels.each do |label|
        #Remove comment in order to get debug
        puts("#{label.name} - #{label.confidence}")
        unless 
          label.parent_name == "Suggestive"
          break
        end
      end

      if flag
        meme.hidden = true
        #To do....
        #Ban user for 24H and kill him on second offense
        ## Set up mailers to notify user his offense
      end
    }
  end
end