# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

def dev_pods
  pod 'SwiftLint', '~> 0.39.2'
end
 
def internal_pods
  pod 'MarvelUIKit', :git => 'https://github.com/Vandcarlos/MarvelUIKit', :branch => '0.1.0'
  pod 'MarvelAPI', :git => 'https://github.com/Vandcarlos/MarvelAPI', :branch => '0.1.0'
end

target 'Marvel' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Marvel
  internal_pods
  dev_pods

  pod 'RealmSwift', '~> 5.2.0'

  target 'MarvelTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
