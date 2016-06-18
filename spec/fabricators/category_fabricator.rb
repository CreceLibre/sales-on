#!/bin/env ruby
# encoding: utf-8

Fabricator(:category) do
    id { sequence }
    nombre 'beer'
    ila 20
end
