include Rails.application.routes.url_helpers
require 'dotenv'
require 'aws-sdk'

desc 'Looks for recent memes with a certain number of reports and analyze them!'
namespace :db do
  task :explicit_image => :environment do
    Dotenv.load
    client = Aws::Rekognition::Client.new  
    memes = Meme.with_attached_image.where("report >= 2")
    #memes = Meme.with_attached_image.find(136)
    memes.each{|meme|
      if Rails.env.production?
        #env production not tested yet
        uri = meme.image.service_url
        dir = uri.split("/").fourth
        key = dir.split("?").first
        @params={
          image: {s3_object: {bucket: ENV['AWS_BUCKET'],name: @key}},min_confidence: 70}
        puts("##########"+uri)
      else
        local_route = ActiveStorage::Blob.service.send(:path_for,meme.image.key)
        @params = {
          image: {bytes: File.read(local_route)},
          min_confidence: 70
        }
        puts("##########"+local_route)
      end
      response = client.detect_moderation_labels(@params)
      flag = false
      response.moderation_labels.each{|label|
        puts("#{label.name} - #{label.confidence}")
        unless label.parent_name == "Suggestive"
      }

      if flag
        #To implement stuff....
        #Delete meme?
        #Ban user for 24H and kill him on second offense
        #
        #meme.delete
      end
    }
  end
end