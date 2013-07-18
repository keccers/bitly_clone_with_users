class Url < ActiveRecord::Base
  belongs_to :user
  validates :long, format: {with: /^(http|https):\/\/|[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix, message: "Not a valid URL."}
  validates_uniqueness_of :short, :message => 'This pretty URL has already been taken.'

  # def url_checker(long)
  #   url = URI.parse(long)
  #   request = Net::HTTP.new(url.host, url.port)
  #   response = request.request_head(url.path) 
  # end

end
