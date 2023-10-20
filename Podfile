source 'https://cdn.cocoapods.org/'

TARGET_IOS = '15.0'
SWIFTLINT_VERSION = File.read(".swiftlint-version").strip

if SWIFTLINT_VERSION.empty?
  abort("Error: SwiftLint version is empty. Please check .swiftlint-version file includes a correct version.")
end

platform :ios, TARGET_IOS

use_frameworks!
inhibit_all_warnings!

abstract_target 'defaults' do

  pod 'SwiftLint', "~> #{SWIFTLINT_VERSION}"
  pod 'SwiftFormat/CLI', '~> 0.51.10'
  pod 'R.swift', '~> 7.3.2'

  # App

  target 'Metis'

end
