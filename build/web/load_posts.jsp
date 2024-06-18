<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.entities.Message" %>
<%@page import="com.tech.blog.entities.Category" %>
<%@page import="java.util.*"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>


<%

    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }


%>

<div class="row">
    <%
    //    Thread.sleep(1000);
        PostDao d = new PostDao(ConnectionProvider.getConnection());
    
        int cid = Integer.parseInt(request.getParameter("cid"));
    
        List<Post> posts = null;
        if(cid==0){
            posts = d.getAllPosts();
        }
        else{
            posts = d.getPostByCatId(cid);
        }
        if(posts.size()==0){
            out.println("<h3 class='display-3 text-center'>No Post in this category...</h3>");
            return;
        }
        for(Post p :posts){
    %>
    <div class="col-md-6 mt-2">
        <div class="card">
            <img class="card-img-top" src="D:\\Program Files\\Netbeans\\TechBlog\\web\\pics/<%=p.getpPic()%>">
            <div class="card-body">
                <b><%=p.getpTitle()%></b>
                <p><%=p.getpContent()%></p>
                <pre><%=p.getpCode()%></pre>
            </div>
            <div class="card-footer primary-background text-center">

                <%
                    LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                %>

                <a href="#!" onclick="doLike(<%= p.getPid()%>,<%= user.getId()%>)" class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span>  </a>

                <a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="btn btn-outline-light btn-sm">Read More</a>
                <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"><span>20</span></i></a>
            </div>
        </div>
    </div>
    <%
        }
    %>
</div>