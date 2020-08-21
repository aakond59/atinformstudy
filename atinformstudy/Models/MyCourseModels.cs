using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace atinformstudy.Models
{
    public class MyContent
    {
        public Content content { get; set; }
        public int groupId { get; set; }
        public IEnumerable<HttpPostedFileBase> Uploads { get; set; }
    }

    public class MyComment
    {
        public Comment comment { get; set; }
        public int contentId { get; set; }
        public IEnumerable<HttpPostedFileBase> Uploads { get; set; }
    }
}