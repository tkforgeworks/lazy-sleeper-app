/* @ds-bundle: {"format":4,"namespace":"TKForgeWorksDesignSystem_ad593b","components":[],"sourceHashes":{"ui_kits/website/components.jsx":"7cbc3681e3fd","ui_kits/website/pages.jsx":"658869cd6dab"},"inlinedExternals":[],"unexposedExports":[]} */

(() => {

const __ds_ns = (window.TKForgeWorksDesignSystem_ad593b = window.TKForgeWorksDesignSystem_ad593b || {});

const __ds_scope = {};

(__ds_ns.__errors = __ds_ns.__errors || []);

// ui_kits/website/components.jsx
try { (() => {
/* global React */
const {
  useState
} = React;

// ---- ThemeToggle ---------------------------------------------------------
function ThemeToggle({
  theme,
  setTheme
}) {
  const cycle = () => setTheme(theme === "light" ? "dark" : theme === "dark" ? "system" : "light");
  return /*#__PURE__*/React.createElement("button", {
    onClick: cycle,
    className: "tk-toggle",
    title: `Theme: ${theme}`,
    "aria-label": `Theme: ${theme}`
  }, theme === "light" && /*#__PURE__*/React.createElement("svg", {
    width: "20",
    height: "20",
    fill: "none",
    viewBox: "0 0 24 24",
    stroke: "currentColor",
    strokeWidth: "2"
  }, /*#__PURE__*/React.createElement("path", {
    strokeLinecap: "round",
    strokeLinejoin: "round",
    d: "M12 3v1m0 16v1m8.66-13.66l-.71.71M4.05 19.95l-.71.71M21 12h-1M4 12H3m16.66 7.66l-.71-.71M4.05 4.05l-.71-.71M16 12a4 4 0 11-8 0 4 4 0 018 0z"
  })), theme === "dark" && /*#__PURE__*/React.createElement("svg", {
    width: "20",
    height: "20",
    fill: "none",
    viewBox: "0 0 24 24",
    stroke: "currentColor",
    strokeWidth: "2"
  }, /*#__PURE__*/React.createElement("path", {
    strokeLinecap: "round",
    strokeLinejoin: "round",
    d: "M20.354 15.354A9 9 0 018.646 3.646 9.005 9.005 0 0012 21a9.005 9.005 0 008.354-5.646z"
  })), theme === "system" && /*#__PURE__*/React.createElement("svg", {
    width: "20",
    height: "20",
    fill: "none",
    viewBox: "0 0 24 24",
    stroke: "currentColor",
    strokeWidth: "2"
  }, /*#__PURE__*/React.createElement("path", {
    strokeLinecap: "round",
    strokeLinejoin: "round",
    d: "M9.75 17L9 20l-1 1h8l-1-1-.75-3M3 13h18M5 17h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"
  })));
}

// ---- Header --------------------------------------------------------------
const NAV = [{
  id: "home",
  label: "Home"
}, {
  id: "about",
  label: "About"
}, {
  id: "projects",
  label: "Projects"
}, {
  id: "blog",
  label: "Blog"
}, {
  id: "faq",
  label: "FAQ"
}, {
  id: "contact",
  label: "Contact"
}];
function Header({
  route,
  setRoute,
  theme,
  setTheme
}) {
  const active = route.split(":")[0];
  return /*#__PURE__*/React.createElement("header", {
    className: "tk-header"
  }, /*#__PURE__*/React.createElement("div", {
    className: "tk-header-inner"
  }, /*#__PURE__*/React.createElement("a", {
    className: "tk-brand",
    onClick: () => setRoute("home"),
    role: "button"
  }, /*#__PURE__*/React.createElement("img", {
    className: "tk-brand-mark",
    src: "../../assets/logo/tkforgeworks-mark.svg",
    alt: "",
    "aria-hidden": "true"
  }), "TK ForgeWorks"), /*#__PURE__*/React.createElement("div", {
    className: "tk-header-right"
  }, /*#__PURE__*/React.createElement("nav", {
    className: "tk-nav"
  }, NAV.map(n => /*#__PURE__*/React.createElement("a", {
    key: n.id,
    className: "tk-nav-link" + (active === n.id ? " active" : ""),
    onClick: () => setRoute(n.id),
    role: "button"
  }, n.label))), /*#__PURE__*/React.createElement(ThemeToggle, {
    theme: theme,
    setTheme: setTheme
  }))));
}

// ---- Footer --------------------------------------------------------------
function Footer({
  setRoute
}) {
  return /*#__PURE__*/React.createElement("footer", {
    className: "tk-footer"
  }, /*#__PURE__*/React.createElement("div", {
    className: "tk-footer-inner"
  }, /*#__PURE__*/React.createElement("div", {
    className: "tk-footer-row"
  }, /*#__PURE__*/React.createElement("div", null, /*#__PURE__*/React.createElement("a", {
    className: "tk-brand sm",
    onClick: () => setRoute("home"),
    role: "button"
  }, "TK ForgeWorks"), /*#__PURE__*/React.createElement("p", {
    className: "tk-footer-tag"
  }, "Where problem-solving meets \u201Clet\u2019s see what happens if I try this\u201D")), /*#__PURE__*/React.createElement("nav", {
    className: "tk-footer-nav"
  }, /*#__PURE__*/React.createElement("a", {
    onClick: () => setRoute("about"),
    role: "button"
  }, "About"), /*#__PURE__*/React.createElement("a", {
    onClick: () => setRoute("projects"),
    role: "button"
  }, "Projects"), /*#__PURE__*/React.createElement("a", {
    onClick: () => setRoute("blog"),
    role: "button"
  }, "Blog"), /*#__PURE__*/React.createElement("a", {
    onClick: () => setRoute("contact"),
    role: "button"
  }, "Contact"))), /*#__PURE__*/React.createElement("div", {
    className: "tk-footer-bottom"
  }, /*#__PURE__*/React.createElement("p", null, "\xA9 ", new Date().getFullYear(), " TK ForgeWorks. Built with stubborn persistence."))));
}

// ---- Buttons -------------------------------------------------------------
function Button({
  variant = "primary",
  children,
  onClick,
  as = "button"
}) {
  const cls = "tk-btn tk-btn-" + variant;
  if (as === "a") return /*#__PURE__*/React.createElement("a", {
    className: cls,
    onClick: onClick,
    role: "button"
  }, children);
  return /*#__PURE__*/React.createElement("button", {
    className: cls,
    onClick: onClick
  }, children);
}

// ---- Tags ----------------------------------------------------------------
function StatusTag({
  status
}) {
  const map = {
    Active: "ok",
    Completed: "ok",
    Paused: "warn",
    Planning: "info",
    Broken: "err"
  };
  const v = map[status] || "neutral";
  return /*#__PURE__*/React.createElement("span", {
    className: "tk-status tk-status-" + v
  }, status);
}
function TechTag({
  children
}) {
  return /*#__PURE__*/React.createElement("span", {
    className: "tk-tech"
  }, children);
}

// ---- Cards ---------------------------------------------------------------
function ProjectCard({
  project,
  onOpen
}) {
  return /*#__PURE__*/React.createElement("a", {
    className: "tk-card",
    onClick: onOpen,
    role: "button"
  }, /*#__PURE__*/React.createElement("h3", {
    className: "tk-card-title"
  }, project.title), /*#__PURE__*/React.createElement(StatusTag, {
    status: project.status
  }), /*#__PURE__*/React.createElement("p", {
    className: "tk-card-excerpt"
  }, project.excerpt), /*#__PURE__*/React.createElement("div", {
    className: "tk-card-tags"
  }, project.tech.map(t => /*#__PURE__*/React.createElement(TechTag, {
    key: t
  }, t))));
}
function BlogCard({
  post,
  onOpen
}) {
  return /*#__PURE__*/React.createElement("a", {
    className: "tk-card",
    onClick: onOpen,
    role: "button"
  }, /*#__PURE__*/React.createElement("time", {
    className: "tk-card-date"
  }, new Date(post.date).toLocaleDateString("en-US", {
    year: "numeric",
    month: "long",
    day: "numeric"
  })), /*#__PURE__*/React.createElement("h3", {
    className: "tk-card-title"
  }, post.title), /*#__PURE__*/React.createElement("p", {
    className: "tk-card-excerpt"
  }, post.excerpt));
}

// ---- Alert ---------------------------------------------------------------
function Alert({
  variant,
  title,
  children
}) {
  return /*#__PURE__*/React.createElement("div", {
    className: "tk-alert tk-alert-" + variant
  }, /*#__PURE__*/React.createElement("div", {
    className: "tk-alert-title"
  }, title), /*#__PURE__*/React.createElement("div", {
    className: "tk-alert-text"
  }, children));
}

// ---- Section -------------------------------------------------------------
function Section({
  tone = "default",
  children
}) {
  return /*#__PURE__*/React.createElement("section", {
    className: "tk-section tk-section-" + tone
  }, /*#__PURE__*/React.createElement("div", {
    className: "tk-container"
  }, children));
}
Object.assign(window, {
  Header,
  Footer,
  ThemeToggle,
  Button,
  StatusTag,
  TechTag,
  ProjectCard,
  BlogCard,
  Alert,
  Section
});
})(); } catch (e) { __ds_ns.__errors.push({ path: "ui_kits/website/components.jsx", error: String((e && e.message) || e) }); }

// ui_kits/website/pages.jsx
try { (() => {
/* global React, Header, Footer, Button, StatusTag, TechTag, ProjectCard, BlogCard, Alert, Section */

const PROJECTS = [{
  slug: "aether-gears",
  title: "Aether Gears",
  status: "Active",
  featured: true,
  excerpt: "Action RPG about corporate greed and resource exploitation",
  tech: ["Unity", "C#", "Game Development"],
  body: [{
    h: "The Vision",
    p: "Aether Gears combines fast-paced combat with a narrative about corporate overreach and the consequences of unchecked resource extraction. Think \u201cwhat if your day job frustrations became a game mechanic?\u201d"
  }, {
    h: "Current Status",
    p: "Actively in development. Learning every day that game development involves approximately 47 more disciplines than I initially expected."
  }, {
    h: "What I'm Learning",
    list: ["Game architecture and state management", "The art of scope management (or the lack thereof)", "Why indie devs drink so much coffee", "That \u201cplaceholder art\u201d has a way of becoming permanent"]
  }]
}, {
  slug: "modular-organizers",
  title: "Modular Kitchen Organizers",
  status: "Completed",
  featured: true,
  excerpt: "3D-printed modular organization system that actually tamed the cable chaos",
  tech: ["3D Printing", "CAD", "Hardware"],
  body: [{
    h: "The Problem",
    p: "Kitchen drawers were a disaster. Cables everywhere, utensils playing musical chairs, and that one junk drawer that had achieved sentient chaos."
  }, {
    h: "The Solution",
    p: "Custom-designed modular organizer system that snaps together and can be reconfigured as needs change. Only took three iterations to get right, which by my standards is practically speed-running."
  }, {
    h: "What I Learned",
    list: ["Measure twice, print once (or in my case, measure once, print three times)", "The satisfaction of solving a physical problem with engineering", "That \u201cgood enough\u201d is sometimes the enemy of \u201cactually done\u201d"]
  }]
}, {
  slug: "mtg-tracker",
  title: "MTG Collection Tracker",
  status: "Active",
  featured: true,
  excerpt: "Magic: The Gathering collection tracker built with Java and Spring",
  tech: ["Java", "Spring Boot", "PostgreSQL"],
  body: [{
    h: "The Goal",
    p: "Build a comprehensive tool for tracking MTG collections, deck building, and card valuation. The MVP handles basic collection management, with grand plans for computer vision card recognition somewhere down the road."
  }, {
    h: "Current Status",
    p: "The MVP works! Basic collection management is functional. The computer vision dream is a few learning curves away, but the foundation is solid."
  }, {
    h: "Tech Stack",
    p: "Built with Java and Spring Boot because sometimes you want a robust backend that doesn\u2019t make you question your life choices. PostgreSQL handles the data, and the API is clean enough that I\u2019m not embarrassed to show it."
  }]
}];
const POSTS = [{
  slug: "why-i-started-tkforgeworks",
  title: "Why I Started TK ForgeWorks",
  date: "2024-07-30",
  tags: ["personal", "origin-story"],
  excerpt: "The origin story of a mechanical engineer\u2019s escape from corporate committees into creative problem-solving",
  body: [{
    p: "Every side project starts with the same dangerous thought: \u201cHow hard could it be?\u201d"
  }, {
    p: "TK ForgeWorks began as a name I gave to the corner of my desk where personal projects lived. You know the spot \u2014 the one with the half-assembled prototype, three notebooks full of ideas, and a coffee stain that\u2019s been there so long it\u2019s practically a design feature."
  }, {
    h: "The Day Job"
  }, {
    p: "By day, I\u2019m a mechanical engineer herding cross-functional teams to bring transit systems to life. It\u2019s rewarding work \u2014 there\u2019s something deeply satisfying about seeing infrastructure you helped design carrying actual people around actual cities. But it comes with the usual corporate package: customer requirements, regulatory approval, and meetings about meetings about the meetings we had last week."
  }, {
    h: "The Escape Hatch"
  }, {
    p: "TK ForgeWorks is where I get to ask \u201cwhat if?\u201d without submitting a change request form. Where I can overengineer a kitchen organizer just because I want to. Where I can decide to build an entire action RPG as my first game development project and have nobody around to tell me that\u2019s an absurd scope for a solo developer with no art skills."
  }, {
    p: "The name itself is half-serious, half-aspirational. \u201cTK\u201d for my initials. \u201cForgeWorks\u201d because I liked romanticizing the idea of a one-person workshop where raw materials become useful things through sheer stubbornness. Like a blacksmith, except instead of horseshoes, I\u2019m making things that occasionally compile."
  }, {
    h: "What's Here"
  }, {
    list: ["Projects in various states of ambition and completion", "Blog posts documenting what I\u2019m learning (and what I\u2019m learning the hard way)", "An FAQ that preemptively answers questions nobody has asked yet"]
  }, {
    p: "Welcome to the forge. Mind the sparks."
  }]
}];
const FAQ = [{
  section: "Project Management & Process",
  items: [{
    q: "How long do your projects actually take?",
    a: "Multiply my initial estimate by three, add a month for \u201cunexpected learning opportunities,\u201d and you\u2019re in the ballpark. I\u2019m getting better at estimating, but optimism is a hard habit to break."
  }, {
    q: "What\u2019s the deal with all the unfinished projects?",
    a: "They\u2019re not unfinished \u2014 they\u2019re \u201cin various stages of completion.\u201d Each one taught me something valuable, and several are actively being worked on."
  }, {
    q: "Do you ever actually finish anything?",
    a: "Yes! The modular kitchen organizers are done and actually in use. The MTG tracker MVP works. I just tend to have more ideas than hours in the day."
  }]
}, {
  section: "Technical & Skills",
  items: [{
    q: "What\u2019s your development setup?",
    a: "A mix of VS Code, Unity, and whatever terminal I haven\u2019t accidentally closed. I\u2019m a mechanical engineer who learned to code, so my setup is practical rather than aesthetic."
  }, {
    q: "How did you learn game development without formal training?",
    a: "YouTube tutorials, documentation rabbit holes, a lot of trial and error, and the stubborn refusal to accept \u201cyou can\u2019t do that\u201d as a final answer."
  }]
}];

// ---- Pages ---------------------------------------------------------------
function HomePage({
  setRoute
}) {
  return /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement(Section, {
    tone: "muted"
  }, /*#__PURE__*/React.createElement("div", {
    className: "tk-hero"
  }, /*#__PURE__*/React.createElement("h1", {
    className: "tk-display"
  }, "TK ForgeWorks"), /*#__PURE__*/React.createElement("p", {
    className: "tk-tagline"
  }, "Where problem-solving meets \u201Clet\u2019s see what happens if I try ", /*#__PURE__*/React.createElement("em", null, "this"), ".\u201D"), /*#__PURE__*/React.createElement("p", {
    className: "tk-lede"
  }, "Engineering solutions and creative projects through trial, error, and stubborn persistence."), /*#__PURE__*/React.createElement("div", {
    className: "tk-cta-row"
  }, /*#__PURE__*/React.createElement(Button, {
    onClick: () => setRoute("projects")
  }, "View Projects"), /*#__PURE__*/React.createElement(Button, {
    variant: "secondary",
    onClick: () => setRoute("about")
  }, "Read About Me")))), /*#__PURE__*/React.createElement(Section, null, /*#__PURE__*/React.createElement("h2", {
    className: "tk-section-title"
  }, "Featured Projects"), /*#__PURE__*/React.createElement("div", {
    className: "tk-grid-3"
  }, PROJECTS.filter(p => p.featured).map(p => /*#__PURE__*/React.createElement(ProjectCard, {
    key: p.slug,
    project: p,
    onOpen: () => setRoute("projects:" + p.slug)
  })))), /*#__PURE__*/React.createElement(Section, {
    tone: "muted"
  }, /*#__PURE__*/React.createElement("h2", {
    className: "tk-section-title"
  }, "Recent Posts"), /*#__PURE__*/React.createElement("div", {
    className: "tk-grid-3"
  }, POSTS.map(p => /*#__PURE__*/React.createElement(BlogCard, {
    key: p.slug,
    post: p,
    onOpen: () => setRoute("blog:" + p.slug)
  })))));
}
function ProjectsPage({
  setRoute
}) {
  return /*#__PURE__*/React.createElement(Section, null, /*#__PURE__*/React.createElement("h1", {
    className: "tk-page-title"
  }, "Projects"), /*#__PURE__*/React.createElement("p", {
    className: "tk-page-lede"
  }, "This is where good intentions meet reality checks. A mix of \u201Cdefinitely finishing this\u201D and \u201Cseemed like a good idea at 3 AM\u201D projects."), /*#__PURE__*/React.createElement("div", {
    className: "tk-grid-3",
    style: {
      marginTop: "2.5rem"
    }
  }, PROJECTS.map(p => /*#__PURE__*/React.createElement(ProjectCard, {
    key: p.slug,
    project: p,
    onOpen: () => setRoute("projects:" + p.slug)
  }))));
}
function ProjectDetailPage({
  slug,
  setRoute
}) {
  const p = PROJECTS.find(x => x.slug === slug) || PROJECTS[0];
  return /*#__PURE__*/React.createElement(Section, null, /*#__PURE__*/React.createElement("a", {
    className: "tk-back",
    onClick: () => setRoute("projects"),
    role: "button"
  }, "\u2190 Back to Projects"), /*#__PURE__*/React.createElement("h1", {
    className: "tk-page-title",
    style: {
      marginTop: "1.25rem"
    }
  }, p.title), /*#__PURE__*/React.createElement("div", {
    className: "tk-meta-row"
  }, /*#__PURE__*/React.createElement(StatusTag, {
    status: p.status
  })), /*#__PURE__*/React.createElement("div", {
    className: "tk-card-tags",
    style: {
      marginTop: "0.75rem"
    }
  }, p.tech.map(t => /*#__PURE__*/React.createElement(TechTag, {
    key: t
  }, t))), /*#__PURE__*/React.createElement("article", {
    className: "tk-prose"
  }, /*#__PURE__*/React.createElement("p", null, p.excerpt, "."), p.body.map((b, i) => /*#__PURE__*/React.createElement(React.Fragment, {
    key: i
  }, b.h && /*#__PURE__*/React.createElement("h2", null, b.h), b.p && /*#__PURE__*/React.createElement("p", null, b.p), b.list && /*#__PURE__*/React.createElement("ul", null, b.list.map((li, j) => /*#__PURE__*/React.createElement("li", {
    key: j
  }, li)))))));
}
function AboutPage() {
  return /*#__PURE__*/React.createElement(Section, null, /*#__PURE__*/React.createElement("h1", {
    className: "tk-page-title"
  }, "About"), /*#__PURE__*/React.createElement("p", {
    className: "tk-page-lede"
  }, "The story behind the forge"), /*#__PURE__*/React.createElement("div", {
    className: "tk-image-frame"
  }, /*#__PURE__*/React.createElement("div", {
    className: "tk-image-placeholder"
  }, "Workspace photo placeholder"), /*#__PURE__*/React.createElement("p", {
    className: "tk-caption"
  }, "Placeholder \u2014 swap this out for a real profile photo or workspace shot")), /*#__PURE__*/React.createElement("article", {
    className: "tk-prose"
  }, /*#__PURE__*/React.createElement("p", null, /*#__PURE__*/React.createElement("strong", null, "TK ForgeWorks"), " is where problem-solving meets \u201Clet\u2019s see what happens if I try ", /*#__PURE__*/React.createElement("em", null, "this"), ".\u201D I\u2019m a mechanical engineer by day, herding cross-functional teams to bring transit systems to life \u2014 but this studio is where I escape corporate committees and actually get to break things on purpose. You\u2019ll find projects spanning hardware fixes, software experiments, and my slightly delusional belief that I can learn game development without any formal creative training."), /*#__PURE__*/React.createElement("p", null, "The name comes from my initials and romanticizing the idea of a forge \u2014 that mythical single-person workshop where raw materials become something useful through sheer stubbornness. Like a blacksmith who creates beautiful work while insisting they\u2019re \u201Cjust hitting metal with a hammer,\u201D I\u2019m drawn to building things that solve problems, even if I have to learn half the skills along the way."), /*#__PURE__*/React.createElement("p", null, "This whole venture started because my day job, while rewarding, comes with the usual corporate constraints: customer requirements, regulatory approval, and meetings about meetings. Here, I get to ask \u201Cwhat if?\u201D without having to justify ROI to anyone but myself."), /*#__PURE__*/React.createElement("p", null, "If you\u2019re into elegant solutions, questionable project scope, or have ideas that need someone willing to figure things out through trial and error, let\u2019s connect.")));
}
function BlogPage({
  setRoute
}) {
  return /*#__PURE__*/React.createElement(Section, null, /*#__PURE__*/React.createElement("h1", {
    className: "tk-page-title"
  }, "Blog"), /*#__PURE__*/React.createElement("p", {
    className: "tk-page-lede"
  }, "Documenting what I\u2019m learning, including the parts I\u2019m learning the hard way."), /*#__PURE__*/React.createElement("div", {
    className: "tk-grid-2",
    style: {
      marginTop: "2.5rem"
    }
  }, POSTS.map(p => /*#__PURE__*/React.createElement(BlogCard, {
    key: p.slug,
    post: p,
    onOpen: () => setRoute("blog:" + p.slug)
  }))));
}
function BlogPostPage({
  slug,
  setRoute
}) {
  const p = POSTS.find(x => x.slug === slug) || POSTS[0];
  return /*#__PURE__*/React.createElement(Section, null, /*#__PURE__*/React.createElement("a", {
    className: "tk-back",
    onClick: () => setRoute("blog"),
    role: "button"
  }, "\u2190 Back to Blog"), /*#__PURE__*/React.createElement("h1", {
    className: "tk-page-title",
    style: {
      marginTop: "1.25rem"
    }
  }, p.title), /*#__PURE__*/React.createElement("p", {
    className: "tk-caption"
  }, new Date(p.date).toLocaleDateString("en-US", {
    year: "numeric",
    month: "long",
    day: "numeric"
  }), " \u00b7 ", " ", p.tags.join(", ")), /*#__PURE__*/React.createElement("article", {
    className: "tk-prose"
  }, p.body.map((b, i) => /*#__PURE__*/React.createElement(React.Fragment, {
    key: i
  }, b.h && /*#__PURE__*/React.createElement("h2", null, b.h), b.p && /*#__PURE__*/React.createElement("p", null, b.p), b.list && /*#__PURE__*/React.createElement("ul", null, b.list.map((li, j) => /*#__PURE__*/React.createElement("li", {
    key: j
  }, li)))))));
}
function ContactPage() {
  return /*#__PURE__*/React.createElement(Section, null, /*#__PURE__*/React.createElement("h1", {
    className: "tk-page-title"
  }, "Contact"), /*#__PURE__*/React.createElement("p", {
    className: "tk-prose-lede"
  }, "Got an idea that\u2019s either brilliant or completely unhinged? Perfect \u2014 those are my favorite kind. Whether you\u2019re looking to collaborate on something equally ambitious, need a second pair of eyes on a technical challenge, or just want to commiserate about why your code worked yesterday but not today, drop me a line."), /*#__PURE__*/React.createElement("p", {
    className: "tk-prose-secondary"
  }, "I promise to respond faster than I finish my personal projects, which admittedly isn\u2019t setting the bar very high."), /*#__PURE__*/React.createElement("div", {
    className: "tk-contact-card"
  }, /*#__PURE__*/React.createElement("h2", {
    className: "tk-section-title sm"
  }, "Get in Touch"), /*#__PURE__*/React.createElement("p", {
    className: "tk-caption"
  }, "Contact form coming soon. In the meantime, feel free to reach out through the channels below."), /*#__PURE__*/React.createElement("div", {
    className: "tk-contact-rows"
  }, /*#__PURE__*/React.createElement("div", null, /*#__PURE__*/React.createElement("span", {
    className: "tk-contact-label"
  }, "Email"), /*#__PURE__*/React.createElement("p", null, "info@tkforgeworks.com")), /*#__PURE__*/React.createElement("div", null, /*#__PURE__*/React.createElement("span", {
    className: "tk-contact-label"
  }, "Response Time"), /*#__PURE__*/React.createElement("p", {
    className: "muted"
  }, "Usually within 24-48 hours")), /*#__PURE__*/React.createElement("div", null, /*#__PURE__*/React.createElement("span", {
    className: "tk-contact-label"
  }, "Best Topics"), /*#__PURE__*/React.createElement("ul", {
    className: "muted"
  }, /*#__PURE__*/React.createElement("li", null, "Technical collaboration"), /*#__PURE__*/React.createElement("li", null, "Project consulting"), /*#__PURE__*/React.createElement("li", null, "Game development discussions"), /*#__PURE__*/React.createElement("li", null, "Engineering problem solving"))))), /*#__PURE__*/React.createElement("div", {
    style: {
      marginTop: "1.5rem"
    }
  }, /*#__PURE__*/React.createElement(Alert, {
    variant: "info",
    title: "Documentation update"
  }, "Email is the fastest channel right now \u2014 the contact form is queued behind one of those \u201Cseemed like a good idea at 3 AM\u201D tickets.")));
}
function FaqPage() {
  return /*#__PURE__*/React.createElement(Section, null, /*#__PURE__*/React.createElement("h1", {
    className: "tk-page-title"
  }, "FAQ"), /*#__PURE__*/React.createElement("p", {
    className: "tk-page-lede"
  }, "The questions nobody\u2019s asked yet, but probably should."), /*#__PURE__*/React.createElement("article", {
    className: "tk-prose"
  }, FAQ.map((g, i) => /*#__PURE__*/React.createElement(React.Fragment, {
    key: i
  }, /*#__PURE__*/React.createElement("h2", null, g.section), g.items.map((it, j) => /*#__PURE__*/React.createElement(React.Fragment, {
    key: j
  }, /*#__PURE__*/React.createElement("p", null, /*#__PURE__*/React.createElement("strong", null, it.q)), /*#__PURE__*/React.createElement("p", null, it.a)))))));
}
Object.assign(window, {
  HomePage,
  ProjectsPage,
  ProjectDetailPage,
  AboutPage,
  BlogPage,
  BlogPostPage,
  ContactPage,
  FaqPage
});
})(); } catch (e) { __ds_ns.__errors.push({ path: "ui_kits/website/pages.jsx", error: String((e && e.message) || e) }); }

})();
