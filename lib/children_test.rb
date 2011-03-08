#=============================================================================
#
# Copyright 2007 Adam Wisniewski <adamw@tbcn.ca> 
# Contributions by Andrew Turner, High Earth Orbit
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at 
#
#  http://www.apache.org/licenses/LICENSE-2.0 
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.
#
#=============================================================================

require 'geonames'
require 'pp'

children = Geonames::WebService.children_search( 3175395 )
p children

#postal_code_sc = Geonames::PostalCodeSearchCriteria.new
#postal_code_sc.place_name = "Seveso"
#postal_codes = Geonames::WebService.postal_code_search postal_code_sc
#p postal_codes


