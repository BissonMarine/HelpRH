// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import ResultscrollController from "./resultscroll_controller"
application.register("resultscroll", ResultscrollController)

import SpinnerController from "./spinner_controller"
application.register("spinner", SpinnerController)

import DropdownsController from "./dropdowns_controller"
application.register("dropdowns", DropdownsController)
