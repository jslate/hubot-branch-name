chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'Branch Name:', ->
  branch_name_module = require('../src/branch-name')

  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()
    @msg =
      send: sinon.spy()
      random: sinon.spy()
    @branch_name_module = branch_name_module(@robot)

  describe 'record a vote', ->

    # TODO
