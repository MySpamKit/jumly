RobustnessDiagramBuilder = require "RobustnessDiagramBuilder.coffee"

describe "RobustnessDiagramBuilder", ->
  
  describe "actor", ->
  
    describe "without dst", ->
      it "creates an actor having .actor", ->
        diag = new RobustnessDiagramBuilder().build """ @actor "a" """
        expect(diag.find(".actor").length).toBe 1

    describe "with a dst", ->
      it "creates two actors", ->
        diag = new RobustnessDiagramBuilder().build """ @actor "a" :-> @actor "b" """
        expect(diag.find(".actor").length).toBe 2


  describe "examples", ->

    describe "scripting", ->

      beforeEach ->
        @diagram = new RobustnessDiagramBuilder().build """
          @actor "browser": -> @view "HTTP"
          @view "HTTP": -> @controller "webapp"
          @controller "webapp": -> @entity "DB"
        """

      it "has two elements", ->
        expect(@diagram.find(".element").length).toBe 4
        expect(@diagram.find(".relationship").length).toBe 3


    xdescribe "markup", ->

      beforeEach ->
        html = $ """
                 <li><i data-kind="actor">An user<i> opens <i data-kind="view">Yahoo</i> with his browser.</li>
                 """
        d = new RobustnessDiagramBuilder()
        @diagram = d.build $(html)

      it "has two elements", ->
        expect(@diagram.find(".element").length).toBe 2


  xdescribe "corner cases", ->

    describe "empty string", ->

      it "works well", ->
        diag = new RobustnessDiagramBuilder().build ""
