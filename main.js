// Nav scroll effect
const nav = document.getElementById('nav');
window.addEventListener('scroll', () => {
    nav.classList.toggle('scrolled', window.scrollY > 50);
});

// Scroll reveal
const observer = new IntersectionObserver((entries) => {
    entries.forEach(e => {
        if (e.isIntersecting) e.target.classList.add('visible');
    });
}, { threshold: 0.1 });
document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

// Smooth scroll
document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', e => {
        e.preventDefault();
        const target = document.querySelector(a.getAttribute('href'));
        if (target) {
            target.scrollIntoView({ behavior: 'smooth' });
            document.getElementById('navLinks').classList.remove('open');
        }
    });
});

// Close mobile nav on click outside
document.addEventListener('click', e => {
    const navLinks = document.getElementById('navLinks');
    const toggle = document.querySelector('.nav-toggle');
    if (navLinks.classList.contains('open') && !navLinks.contains(e.target) && !toggle.contains(e.target)) {
        navLinks.classList.remove('open');
    }
});

// Application form handler
function handleApply(e) {
    e.preventDefault();
    const f = e.target;
    const name = f.querySelector('input[type="text"]').value;
    const email = f.querySelector('input[type="email"]').value;
    const country = f.querySelectorAll('select')[0].value;
    const role = f.querySelectorAll('select')[1].value;
    const msg = f.querySelector('textarea').value;
    const subject = encodeURIComponent('Medad Application: ' + role + ' - ' + name);
    const body = encodeURIComponent('Name: ' + name + '\nEmail: ' + email + '\nCountry: ' + country + '\nRole: ' + role + '\n\n' + msg);
    window.location.href = 'mailto:info@medad.om?subject=' + subject + '&body=' + body;
    f.innerHTML = '<div style="padding:2rem;text-align:center"><svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#10b981" stroke-width="2"><path d="m9 12 2 2 4-4"/><circle cx="12" cy="12" r="10"/></svg><h3 style="margin-top:1rem;color:#10b981">Application Submitted!</h3><p style="color:var(--text-muted);margin-top:.5rem">Your email client should open with the details. Thank you!</p></div>';
}
