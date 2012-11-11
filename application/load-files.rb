
# standard ruby libraries
require 'socket'
require 'thread'
require 'rexml/document'
require 'test/unit'
require 'logger'
require 'drb'
require 'md5'

# kill all threads when one fails
Thread.abort_on_exception = true

# common files
require '../common/abstract-manager.rb'
require '../common/configuration-file.rb'
require '../common/config-manager.rb'

# application
require './application/application.rb'
require './application/application-server.rb'
require './application/command.rb'
require './application/result.rb'
require './application/data-link.rb'

# scheduling

## scheduler
require 'scheduling/scheduler/scheduler.rb'
require 'scheduling/scheduler/combination.rb'
require 'scheduling/scheduler/consumer.rb'
require 'scheduling/scheduler/resource.rb'
require 'scheduling/scheduler/scheduling-problem.rb'
require 'scheduling/scheduler/scheduling-solution.rb'

## genetical
require 'scheduling/genetical/chromosome.rb'
require 'scheduling/genetical/population.rb'

## constraint
require 'scheduling/constraint/abstract-constraint.rb'
require 'scheduling/constraint/capacity-constraint.rb'
require 'scheduling/constraint/classroom-distance-constraint.rb'
require 'scheduling/constraint/compulsory-constraint.rb'
require 'scheduling/constraint/elective-constraint.rb'
require 'scheduling/constraint/last-timeslots-constraint.rb'
require 'scheduling/constraint/lunch-break-constraint.rb'
require 'scheduling/constraint/one-course-a-day-constraint.rb'
require 'scheduling/constraint/required-classroom-constraint.rb'
require 'scheduling/constraint/restricted-courses-constraint.rb'
require 'scheduling/constraint/restricted-timeslot-constraint.rb'
require 'scheduling/constraint/teacher-constraint.rb'
require 'scheduling/constraint/teacher-timeslot-constraint.rb'
require 'scheduling/constraint/timeslot-gap-constraint.rb'

## improvement
require 'scheduling/improvement/improvement.rb'
require 'scheduling/improvement/timeslot-improvement.rb'

## school
require 'scheduling/school/classroom.rb'
require 'scheduling/school/course-meeting.rb'
require 'scheduling/school/elective-course-meeting.rb'
require 'scheduling/school/timeslot.rb'
require 'scheduling/school/school.rb'
require 'scheduling/school/lessonslot.rb'
require 'scheduling/school/personal-preference.rb'
require 'scheduling/school/school-scheduler.rb'

# session
require './session/session/abstract-session.rb'
require './session/session/data-admin-session.rb'
require './session/session/student-session.rb'
require './session/session/system-admin-session.rb'
require './session/session/teacher-session.rb'
require './session/view/colors.rb'
require './session/view/abstract-session-viewer.rb'
require './session/view/data-admin-session-viewer.rb'
require './session/view/student-session-viewer.rb'
require './session/view/system-admin-session-viewer.rb'
require './session/view/teacher-session-viewer.rb'
require './session/controller/abstract-session-controller.rb'
require './session/controller/data-admin-session-controller.rb'
require './session/controller/student-session-controller.rb'
require './session/controller/system-admin-session-controller.rb'
require './session/controller/teacher-session-controller.rb'
require './session/factory/abstract-session-factory.rb'
require './session/factory/data-admin-session-factory.rb'
require './session/factory/student-session-factory.rb'
require './session/factory/system-admin-session-factory.rb'
require './session/factory/teacher-session-factory.rb'

# parallelisation
require './parallelisation/node.rb'

# manager
require './manager/auth-manager.rb'
require './manager/data-manager.rb'
require './manager/schedule-manager.rb'
require './manager/session-manager.rb'
require './manager/user-manager.rb'

# user
require './user/abstract-user.rb'
require './user/data-admin-user.rb'
require './user/student-user.rb'
require './user/system-admin-user.rb'
require './user/teacher-user.rb'
