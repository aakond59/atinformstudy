using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(atinformstudy.Startup))]
namespace atinformstudy
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
