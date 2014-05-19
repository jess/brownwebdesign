module HandleSsl
  extend ActiveSupport::Concern

  included do
    before_filter :redirect_to_ssl, :redirect_to_normal_domain if Rails.env.production?
  end

  def redirect_to_ssl
    if on_ssl_required_page? && on_normal_domain?
      redirect_to "https://brownwebdesign.herokuapp.com#{request.path}" 
    end
  end

  def redirect_to_normal_domain
    if !on_normal_domain? && !on_ssl_required_page?
      redirect_to "http://www.brownwebdesign.com#{request.path}", :status => 301
    end
  end

  def on_normal_domain?
    request.domain == "brownwebdesign.com"
  end

  def on_ssl_required_page?
    ssl_only_list.include? request.path
  end

  def ssl_only_list
    ["/payments", "/charges"]
  end
end
