platform :ios, '10.0'
use_frameworks!
source 'https://github.com/CocoaPods/Specs.git'

target 'BDD' do
    pod 'SwiftLint'
    pod 'Alamofire', '~> 5.0.0-beta.5'
    pod 'SwiftyJSON', '~> 4.0'
end

def testing_pods
    pod 'Quick'
    pod 'Nimble'
end

target 'BDDTests' do
    testing_pods
end

target 'BDDUITests' do
    testing_pods
end