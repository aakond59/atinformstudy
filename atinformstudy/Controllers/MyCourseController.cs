using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Diagnostics.Eventing.Reader;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using atinformstudy.Models;
using System.IO;
using Ganss.XSS;

namespace atinformstudy.Controllers
{
    public class MyCourseController : Controller
    {
        // GET: MyCourse
        [Authorize]
        public ActionResult Index()
        {
            ViewBag.Current = "MyCourse";
            var db = new ATinformContainer();         
            var myGroups = db.GroupStudentSet.ToList();
            return View(myGroups);
        }

        [Authorize(Roles = "teacher")]
        public ActionResult StartGroup(int id)
        {
            using (var db = new ATinformContainer())
            {
                string curUser = User.Identity.GetUserId();
                var group = db.GroupSet.Find(id);
                group.Curator = db.AtUserSet.Where(elm => elm.AspNetID == curUser).First();
                group.StartDate = DateTime.Now;
                group.Started = true;
                db.Entry(group).State = System.Data.Entity.EntityState.Modified;                
                var helloContent = new Content { Group = group, PostedDate = DateTime.Now, AtUser = group.Curator, PostTheme = "Приветствуем Вас на нашем курсе!"};
                helloContent.Text = "<p>Приветствуем Вас на курсе " + group.Course.Name + "! На данной странице куратор будет публиковать учебные материалы, вебинары и их расписание, а также другие новости, связанные с прохождением курса. Желаем Вам продуктивно провести время!</p><br>С уважением, учебный центр ГК «АТ-информ».";
                db.ContentSet.Add(helloContent);
                db.SaveChanges();
                return RedirectToAction("SelectedCourse/"+group.Id);
            }
        }

        [Authorize(Roles = "teacher")]
        public ActionResult FinishGroup(int id)
        {
            using (var db = new ATinformContainer())
            {
                var group = db.GroupSet.Find(id);
                group.FinishDate = DateTime.Now;
                group.Finished = true;
                db.Entry(group).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
        }

        [Authorize]
        public ActionResult SelectedCourse(int id)
        {
            ViewBag.Current = "MyCourse";
            var db = new ATinformContainer();
            var group = db.GroupSet.Find(id);
            string aspnetid = User.Identity.GetUserId();
            int curuser = db.AtUserSet.Where(elm => elm.AspNetID == aspnetid).First().Id;
            int count = db.GroupStudentSet.Where(elm => elm.Group.Id == id && elm.Student.Id == curuser).Count() + db.GroupSet.Where(elm => elm.Id == id && elm.Curator.Id == curuser).Count();
            if (count == 0)
            {
                return HttpNotFound();
            }
            else
            {
                var groupContent = db.ContentSet.Where(elm => elm.Group.Id == group.Id).Include(elm => elm.Comment).ToList();
                return View(groupContent);
            }
        }

        [Authorize]
        public ActionResult CommentSection(int id)
        {
            ViewBag.Current = "MyCourse";
            var db = new ATinformContainer();
            var selContent = db.ContentSet.Find(id);
            string aspnetid = User.Identity.GetUserId();
            int curuser = db.AtUserSet.Where(elm => elm.AspNetID == aspnetid).First().Id;
            int count = db.GroupStudentSet.Where(elm => elm.Group.Id == selContent.Group.Id && elm.Student.Id == curuser).Count() + db.GroupSet.Where(elm => elm.Id == selContent.Group.Id && elm.Curator.Id == curuser).Count();    
            if (count == 0)
            {
                return HttpNotFound();
            }
            else
            {
                return View(selContent);
            }
        }

        [Authorize(Roles = "teacher")]
        [ValidateInput(false)]
        public ActionResult PostContent(MyContent newContent)
        {
            using (var db = new ATinformContainer())
            {
                try
                {
                    newContent.content.PostedDate = DateTime.Now;
                    string curUser = User.Identity.GetUserId();
                    newContent.content.AtUser = db.AtUserSet.Where(elm => elm.AspNetID == curUser).First();
                    newContent.content.Group = db.GroupSet.Find(newContent.groupId);
                    var sanitizer = new HtmlSanitizer();
                    newContent.content.Text = sanitizer.Sanitize(newContent.content.Text);
                    db.ContentSet.Add(newContent.content);
                    db.SaveChanges();
                    foreach (var file in newContent.Uploads)
                    {
                        if (file != null)
                        {
                            var newFile = new Attachment { FileName = Path.GetFileName(file.FileName), FilePath = "~/FileBase/", Content = newContent.content };
                            var path = Path.Combine(Server.MapPath(newFile.FilePath), newFile.FileName);
                            int count = 1;
                            string fileNameOnly = Path.GetFileNameWithoutExtension(path);
                            string extension = Path.GetExtension(path);
                            while (System.IO.File.Exists(path))
                            {
                                string tempFileName = string.Format("{0}({1})", fileNameOnly, count++);
                                newFile.FileName = tempFileName + extension;
                                path = Path.Combine(Server.MapPath(newFile.FilePath), newFile.FileName);
                            }
                            file.SaveAs(path);
                            db.AttachmentSet.Add(newFile);
                        }
                    }
                    db.SaveChanges();
                } catch { }
                int id = newContent.content.Group.Id;
                return RedirectToAction("/SelectedCourse/"+id);
            }
        }

        [Authorize]
        [ValidateInput(false)]
        public ActionResult PostComment(MyComment newComment)
        {
            using (var db = new ATinformContainer())
            {
                newComment.comment.PostedDate = DateTime.Now;
                string curUser = User.Identity.GetUserId();
                newComment.comment.AtUser = db.AtUserSet.Where(elm => elm.AspNetID == curUser).First();
                newComment.comment.Content = db.ContentSet.Find(newComment.contentId);
                var sanitizer = new HtmlSanitizer();
                newComment.comment.Text = sanitizer.Sanitize(newComment.comment.Text);
                db.CommentSet.Add(newComment.comment);
                db.SaveChanges();
                foreach (var file in newComment.Uploads)
                {
                    if (file != null)
                    {
                        var newFile = new Attachment { FileName = Path.GetFileName(file.FileName), FilePath = "~/FileBase/", Comment = newComment.comment };
                        var path = Path.Combine(Server.MapPath(newFile.FilePath), newFile.FileName);
                        int count = 1;
                        string fileNameOnly = Path.GetFileNameWithoutExtension(path);
                        string extension = Path.GetExtension(path);
                        while (System.IO.File.Exists(path))
                        {
                            string tempFileName = string.Format("{0}({1})", fileNameOnly, count++);
                            newFile.FileName = tempFileName + extension;
                            path = Path.Combine(Server.MapPath(newFile.FilePath), newFile.FileName);
                        }
                        file.SaveAs(path);
                        db.AttachmentSet.Add(newFile);
                    }
                }
                db.SaveChanges();
                return RedirectToAction("/CommentSection/" + newComment.contentId);
            }
        }

        public FileResult Download(string filePath, string fileName)
        {
            var FileVirtualPath = HttpContext.Server.MapPath(filePath + fileName);
            return File(FileVirtualPath, "application/force-download", Path.GetFileName(FileVirtualPath));
        }
    }
}