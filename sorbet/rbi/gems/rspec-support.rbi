# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: true
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/rspec-support/all/rspec-support.rbi
#
# rspec-support-3.8.0
module RSpec
  extend RSpec::Support::Warnings
end
module RSpec::Support
  def self.class_of(object); end
  def self.define_optimized_require_for_rspec(lib, &require_relative); end
  def self.deregister_matcher_definition(&block); end
  def self.failure_notifier; end
  def self.failure_notifier=(callable); end
  def self.is_a_matcher?(object); end
  def self.matcher_definitions; end
  def self.method_handle_for(object, method_name); end
  def self.notify_failure(failure, options = nil); end
  def self.register_matcher_definition(&block); end
  def self.require_rspec_support(f); end
  def self.rspec_description_for_object(object); end
  def self.thread_local_data; end
  def self.warning_notifier; end
  def self.warning_notifier=(arg0); end
  def self.with_failure_notifier(callable); end
end
module RSpec::Support::Version
end
class RSpec::Support::ComparableVersion
  def <=>(other); end
  def initialize(string); end
  def segments; end
  def string; end
  include Comparable
end
module RSpec::Support::OS
  def self.windows?; end
  def self.windows_file_path?; end
  def windows?; end
  def windows_file_path?; end
end
module RSpec::Support::Ruby
  def jruby?; end
  def jruby_9000?; end
  def jruby_version; end
  def mri?; end
  def non_mri?; end
  def rbx?; end
  def self.jruby?; end
  def self.jruby_9000?; end
  def self.jruby_version; end
  def self.mri?; end
  def self.non_mri?; end
  def self.rbx?; end
end
module RSpec::Support::RubyFeatures
  def caller_locations_supported?; end
  def fork_supported?; end
  def kw_args_supported?; end
  def module_prepends_supported?; end
  def module_refinement_supported?; end
  def optional_and_splat_args_supported?; end
  def required_kw_args_supported?; end
  def ripper_supported?; end
  def self.caller_locations_supported?; end
  def self.fork_supported?; end
  def self.kw_args_supported?; end
  def self.module_prepends_supported?; end
  def self.module_refinement_supported?; end
  def self.optional_and_splat_args_supported?; end
  def self.required_kw_args_supported?; end
  def self.ripper_supported?; end
  def self.supports_exception_cause?; end
  def self.supports_rebinding_module_methods?; end
  def supports_exception_cause?; end
  def supports_rebinding_module_methods?; end
end
module RSpec::Support::AllExceptionsExceptOnesWeMustNotRescue
  def self.===(exception); end
end
class RSpec::CallerFilter
  def self.first_non_rspec_line(skip_frames = nil, increment = nil); end
end
module RSpec::Support::Warnings
  def deprecate(deprecated, options = nil); end
  def warn_deprecation(message, options = nil); end
  def warn_with(message, options = nil); end
  def warning(text, options = nil); end
end
class RSpec::Support::EncodedString
  def <<(string); end
  def ==(*args, &block); end
  def detect_source_encoding(string); end
  def empty?(*args, &block); end
  def encoding(*args, &block); end
  def eql?(*args, &block); end
  def initialize(string, encoding = nil); end
  def lines(*args, &block); end
  def matching_encoding(string); end
  def remove_invalid_bytes(string); end
  def self.pick_encoding(source_a, source_b); end
  def source_encoding; end
  def split(regex_or_string); end
  def to_s; end
  def to_str; end
end
class RSpec::Support::ReentrantMutex
  def enter; end
  def exit; end
  def initialize; end
  def synchronize; end
end
class RSpec::Support::DirectoryMaker
  def self.directory_exists?(dirname); end
  def self.generate_path(stack, part); end
  def self.generate_stack(path); end
  def self.mkdir_p(path); end
end
module RSpec::Support::RecursiveConstMethods
  def const_defined_on?(mod, const_name); end
  def constants_defined_on(mod); end
  def get_const_defined_on(mod, const_name); end
  def normalize_const_name(const_name); end
  def recursive_const_defined?(const_name); end
  def recursive_const_get(const_name); end
end
module RSpec::Support::FuzzyMatcher
  def self.arrays_match?(expected_list, actual_list); end
  def self.hashes_match?(expected_hash, actual_hash); end
  def self.values_match?(expected, actual); end
end
class RSpec::Support::ObjectFormatter
  def format(object); end
  def initialize(max_formatted_output_length = nil); end
  def max_formatted_output_length; end
  def max_formatted_output_length=(arg0); end
  def prepare_array(array); end
  def prepare_element(element); end
  def prepare_for_inspection(object); end
  def prepare_hash(input_hash); end
  def recursive_structure?(object); end
  def self.default_instance; end
  def self.format(object); end
  def self.prepare_for_inspection(object); end
  def sort_hash_keys(input_hash); end
  def truncate_string(str, start_index, end_index); end
  def with_entering_structure(structure); end
end
class RSpec::Support::ObjectFormatter::InspectableItem < Struct
  def inspect; end
  def pretty_print(pp); end
  def self.[](*arg0); end
  def self.inspect; end
  def self.members; end
  def self.new(*arg0); end
  def text; end
  def text=(_); end
end
class RSpec::Support::ObjectFormatter::BaseInspector < Struct
  def formatter; end
  def formatter=(_); end
  def inspect; end
  def object; end
  def object=(_); end
  def pretty_print(pp); end
  def self.[](*arg0); end
  def self.can_inspect?(_object); end
  def self.inspect; end
  def self.members; end
  def self.new(*arg0); end
end
class RSpec::Support::ObjectFormatter::TimeInspector < RSpec::Support::ObjectFormatter::BaseInspector
  def inspect; end
  def self.can_inspect?(object); end
end
class RSpec::Support::ObjectFormatter::DateTimeInspector < RSpec::Support::ObjectFormatter::BaseInspector
  def inspect; end
  def self.can_inspect?(object); end
end
class RSpec::Support::ObjectFormatter::BigDecimalInspector < RSpec::Support::ObjectFormatter::BaseInspector
  def inspect; end
  def self.can_inspect?(object); end
end
class RSpec::Support::ObjectFormatter::DescribableMatcherInspector < RSpec::Support::ObjectFormatter::BaseInspector
  def inspect; end
  def self.can_inspect?(object); end
end
class RSpec::Support::ObjectFormatter::UninspectableObjectInspector < RSpec::Support::ObjectFormatter::BaseInspector
  def inspect; end
  def klass; end
  def native_object_id; end
  def self.can_inspect?(object); end
end
class RSpec::Support::ObjectFormatter::DelegatorInspector < RSpec::Support::ObjectFormatter::BaseInspector
  def inspect; end
  def self.can_inspect?(object); end
end
class RSpec::Support::ObjectFormatter::InspectableObjectInspector < RSpec::Support::ObjectFormatter::BaseInspector
  def inspect; end
  def self.can_inspect?(object); end
end
class RSpec::Support::MethodSignature
  def arbitrary_kw_args?; end
  def classify_arity(arity = nil); end
  def classify_parameters; end
  def could_contain_kw_args?(args); end
  def description; end
  def has_kw_args_in?(args); end
  def initialize(method); end
  def invalid_kw_args_from(given_kw_args); end
  def max_non_kw_args; end
  def min_non_kw_args; end
  def missing_kw_args_from(given_kw_args); end
  def non_kw_args_arity_description; end
  def optional_kw_args; end
  def required_kw_args; end
  def unlimited_args?; end
  def valid_non_kw_args?(positional_arg_count, optional_max_arg_count = nil); end
end
class RSpec::Support::MethodSignatureExpectation
  def empty?; end
  def expect_arbitrary_keywords; end
  def expect_arbitrary_keywords=(arg0); end
  def expect_unlimited_arguments; end
  def expect_unlimited_arguments=(arg0); end
  def initialize; end
  def keywords; end
  def keywords=(values); end
  def max_count; end
  def max_count=(number); end
  def min_count; end
  def min_count=(number); end
end
class RSpec::Support::BlockSignature < RSpec::Support::MethodSignature
  def classify_parameters; end
end
class RSpec::Support::MethodSignatureVerifier
  def arbitrary_kw_args?; end
  def error_message; end
  def initialize(signature, args = nil); end
  def invalid_kw_args; end
  def kw_args; end
  def max_non_kw_args; end
  def min_non_kw_args; end
  def missing_kw_args; end
  def non_kw_args; end
  def split_args(*args); end
  def unlimited_args?; end
  def valid?; end
  def valid_non_kw_args?; end
  def with_expectation(expectation); end
end
class RSpec::Support::LooseSignatureVerifier < RSpec::Support::MethodSignatureVerifier
  def split_args(*args); end
end
class RSpec::Support::LooseSignatureVerifier::SignatureWithKeywordArgumentsMatcher
  def has_kw_args_in?(args); end
  def initialize(signature); end
  def invalid_kw_args_from(_kw_args); end
  def missing_kw_args_from(_kw_args); end
  def non_kw_args_arity_description; end
  def valid_non_kw_args?(*args); end
end
