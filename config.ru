#!/usr/bin/env -S falcon --count 1 --config
# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
Bundler.require

require_relative './main'
run App.freeze.app
