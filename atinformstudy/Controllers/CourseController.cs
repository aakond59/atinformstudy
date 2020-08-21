using atinformstudy.Models;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace atinformstudy.Controllers
{
    public class CourseController : Controller
    {
        // GET: Course
        public ActionResult Index()
        {
            ViewBag.Current = "Course";
            using (var db = new ATinformContainer())
            {
                var courses = db.CourseSet.ToList();
                return View(courses);
            }
        }

        [Authorize(Roles = "student")]
        public ActionResult Payment(int id)
        {
            ViewBag.Current = "Course";
            using (var db = new ATinformContainer())
            {
                var courses = db.CourseSet.Where(elm=>elm.Id==id).ToList();
                return View(courses.First());
            }
        }

        [Authorize(Roles = "student")]
        public ActionResult FormGroup(int id)
        {
            using (var db = new ATinformContainer())
            { 
                var groups = db.GroupSet.Where(elm => elm.Course.Id == id && elm.Started == false).ToList();
                string curUser = User.Identity.GetUserId();
                if (groups.Count == 0)
                {
                    var newGroup = new Group { Course = db.CourseSet.Find(id), Started = false, Finished = false};
                    db.GroupSet.Add(newGroup);                 
                    var newGroupStudent = new GroupStudent { Group=newGroup, Student=db.AtUserSet.Where(elm => elm.AspNetID == curUser).First()};
                    db.GroupStudentSet.Add(newGroupStudent);
                }
                else
                {
                    var newGroupStudent = new GroupStudent { Group = groups.First(), Student = db.AtUserSet.Where(elm => elm.AspNetID == curUser).First()};
                    db.GroupStudentSet.Add(newGroupStudent);
                }
                db.SaveChanges();
            }
            return RedirectToAction("Index");
        }
    }
}