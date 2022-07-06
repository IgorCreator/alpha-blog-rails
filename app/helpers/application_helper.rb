module ApplicationHelper

  def gravatar_for(user, options = { size: 200 })
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    style = options[:style]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}&d=robohash&r=x"
    image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")
  end
end
