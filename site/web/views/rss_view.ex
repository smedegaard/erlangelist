defmodule Erlangelist.RssView do
  use Erlangelist.Web, :view

  require Erlangelist.Article

  rss_xml =
    """
    <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
      <channel>
        <atom:link href="http://theerlangelist.com/rss" rel="self" type="application/rss+xml" />
        <title>The Erlangelist</title>
        <description>(not only) Erlang related musings</description>
        <link>http://theerlangelist.com</link>
        <%= for article <- Erlangelist.Article.all, article.has_content? do %>
          <item>
            <title><![CDATA[<%= article.long_title %>]]></title>
            <link><![CDATA[http://theerlangelist.com/<%= article.link %>]]></link>
            <pubdate><%= article.posted_at_rfc822 %></pubdate>
            <description>
              <![CDATA[<%= Phoenix.View.render_to_string(Erlangelist.ArticleView, "_article_content.html", article: article) %>]]>
            </description>
            <guid isPermaLink="true">http://theerlangelist.com/<%= article.link %></guid>
          </item>
        <% end %>
      </channel>
    </rss>
    """
    |> EEx.eval_string

  def render("index.xml", _assigns) do
    unquote(rss_xml)
  end
end
