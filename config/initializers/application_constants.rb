Dir[Rails.root.join("config/constants/**/*.rb")].each { |f| require f }
