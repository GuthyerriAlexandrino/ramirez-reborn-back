# The following comments fill some of the gaps in Solargraph's understanding of
# Rails apps. Since they're all in YARD, they get mapped in Solargraph but
# ignored at runtime.
#
# You can put this file anywhere in the project, as long as it gets included in
# the workspace maps. It's recommended that you keep it in a standalone file
# instead of pasting it into an existing one.
#
# @!parse
#   class ActionController::Base
#     include ActionController::MimeResponds
#     extend ActiveSupport::Callbacks::ClassMethods
#     extend AbstractController::Callbacks::ClassMethods
#   end
#   class ActiveRecord::Base
#     include ActiveRecord::QueryMethods
#     include ActiveRecord::FinderMethods
#     include ActiveRecord::Associations::ClassMethods
#     include ActiveRecord::Inheritance::ClassMethods
#     include ActiveRecord::Persistence
#     include Mongoid::Document
#   end
#   class Mongoid::Document
#     include Mongoid::Criteria
#   end
#   class Mongoid::Criteria
#     include Enumerable
#     include Mongoid::Criteria::Inspectable
#     include Mongoid::Criteria::Includable
#     include Mongoid::Criteria::Marshalable
#     include Mongoid::Criteria::Modifiable
#     include Mongoid::Criteria::Scopable
#     include Mongoid::Criteria::Options
#     include Mongoid::Criteria::Contextual
#     include Mongoid::Criteria::Queryable
#     include Mongoid::Criteria::Findable
#   end
#   class Mongoid::Criteria::Queryable
#     include Mongoid::Criteria::Queryable::Aggregable
#     include Mongoid::Criteria::Queryable::Expandable
#     include Mongoid::Criteria::Queryable::Mergeable
#     include Mongoid::Criteria::Queryable::Optional
#     include Mongoid::Criteria::Queryable::Storable
#     include Mongoid::Criteria::Queryable::Selectable
#   end
#   class Mongoid::Criteria::Optional
#     extend Mongoid::Criteria::Macroable
#   end
# @!override ActiveRecord::FinderMethods#find
#   @overload find(id)
#     @param id [Integer]
#     @return [self]
#   @overload find(list)
#     @param list [Array]
#     @return [Array<self>]
#   @overload find(*args)
#     @return [Array<self>]
#   @return [self, Array<self>]
