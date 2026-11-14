/**
 * PortSwigger Web Security Academy - Lab Helper JS
 * Provides live lab status polling, celebratory confetti, JWT token inspector,
 * and quick copy utilities.
 */

// Global State
let wasPreviouslySolved = false;

// Toast Notification
function showToast(message, duration = 2500) {
  let toast = document.getElementById('toast-notice');
  if (!toast) {
    toast = document.createElement('div');
    toast.id = 'toast-notice';
    toast.className = 'toast-notice';
    document.body.appendChild(toast);
  }
  toast.innerHTML = `<span>✓</span> <span>${message}</span>`;
  toast.classList.add('show');
  setTimeout(() => {
    toast.classList.remove('show');
  }, duration);
}

// Copy to Clipboard
function copyToClipboard(text, successMsg = 'Copied to clipboard!') {
  if (navigator.clipboard && window.isSecureContext) {
    navigator.clipboard.writeText(text).then(() => {
      showToast(successMsg);
    }).catch(() => {
      fallbackCopy(text, successMsg);
    });
  } else {
    fallbackCopy(text, successMsg);
  }
}

function fallbackCopy(text, successMsg) {
  const textArea = document.createElement('textarea');
  textArea.value = text;
  textArea.style.position = 'fixed';
  textArea.style.left = '-9999px';
  document.body.appendChild(textArea);
  textArea.focus();
  textArea.select();
  try {
    document.execCommand('copy');
    showToast(successMsg);
  } catch (err) {
    console.error('Copy failed:', err);
  }
  document.body.removeChild(textArea);
}

// Quick Login filler
function fillLogin(user, pass) {
  const userInput = document.getElementById('username');
  const passInput = document.getElementById('password');
  if (userInput && passInput) {
    userInput.value = user;
    passInput.value = pass;
    showToast(`Filled credentials for ${user}`);
  }
}

// Reset Lab State
function resetLab() {
  if (!confirm('Are you sure you want to reset the lab to its initial unsolved state?')) {
    return;
  }
  fetch('/api/reset', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' }
  })
  .then(res => res.json())
  .then(data => {
    showToast('Lab reset successfully!');
    setTimeout(() => {
      window.location.reload();
    }, 600);
  })
  .catch(err => {
    console.error('Reset error:', err);
    alert('Failed to reset lab: ' + err);
  });
}

// Base64URL decode helper
function base64UrlDecode(str) {
  let base64 = str.replace(/-/g, '+').replace(/_/g, '/');
  while (base64.length % 4) {
    base64 += '=';
  }
  try {
    return decodeURIComponent(atob(base64).split('').map(function(c) {
      return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));
  } catch (e) {
    return atob(base64);
  }
}

// JWT Inspector Initializer
function initJwtInspector(rawToken) {
  if (!rawToken || typeof rawToken !== 'string') return;
  const parts = rawToken.trim().split('.');
  if (parts.length !== 3) return;

  const headerB64 = parts[0];
  const payloadB64 = parts[1];
  const signatureB64 = parts[2];

  // Decode JSON
  let headerObj = {};
  let payloadObj = {};
  try {
    headerObj = JSON.parse(base64UrlDecode(headerB64));
  } catch (e) {
    console.error('Header parse err', e);
  }
  try {
    payloadObj = JSON.parse(base64UrlDecode(payloadB64));
  } catch (e) {
    console.error('Payload parse err', e);
  }

  // Populate formatted displays
  const headerElem = document.getElementById('jwt-decoded-header');
  const payloadElem = document.getElementById('jwt-decoded-payload');
  const rawContainer = document.getElementById('jwt-raw-display');

  if (rawContainer) {
    rawContainer.innerHTML = `
      <span class="jwt-part-header" title="Header">${headerB64}</span><span class="jwt-part-dot">.</span><span class="jwt-part-payload" title="Payload">${payloadB64}</span><span class="jwt-part-dot">.</span><span class="jwt-part-signature" title="Signature">${signatureB64}</span>
    `;
  }

  if (headerElem) {
    headerElem.textContent = JSON.stringify(headerObj, null, 2);
  }
  if (payloadElem) {
    payloadElem.textContent = JSON.stringify(payloadObj, null, 2);
  }

  // Show callout for JKU
  const jkuCallout = document.getElementById('jwt-jku-callout');
  if (jkuCallout && headerObj.jku) {
    jkuCallout.style.display = 'block';
    const jkuVal = document.getElementById('jku-value-span');
    if (jkuVal) {
      jkuVal.textContent = headerObj.jku;
    }
  }
}

// Live Status Poller
function pollLabStatus() {
  fetch('/api/lab-status')
    .then(res => {
      if (!res.ok) throw new Error('Status poll failed');
      return res.json();
    })
    .then(data => {
      updateLabStatusUI(data.solved);
    })
    .catch(err => {
      // Silently handle offline/polling issues
    });
}

function updateLabStatusUI(isSolved) {
  const statusBar = document.getElementById('lab-status-bar');
  const statusBadge = document.getElementById('lab-status-badge');
  const statusText = document.getElementById('lab-status-text');

  if (!statusBar || !statusBadge) return;

  if (isSolved) {
    statusBar.className = 'lab-status-bar solved';
    statusBadge.className = 'badge-status solved';
    statusBadge.innerHTML = '✓ SOLVED';
    if (statusText) {
      statusText.innerHTML = '<strong>CONGRATULATIONS, YOU SOLVED THE LAB!</strong>';
    }

    if (!wasPreviouslySolved) {
      wasPreviouslySolved = true;
      triggerConfetti();
      // If on admin page and victory card isn't visible, reload to show victory card
      const victoryCard = document.getElementById('admin-victory-card');
      if (!victoryCard && window.location.pathname.startsWith('/admin')) {
        setTimeout(() => {
          window.location.reload();
        }, 1200);
      }
    }
  } else {
    wasPreviouslySolved = false;
    statusBar.className = 'lab-status-bar unsolved';
    statusBadge.className = 'badge-status unsolved';
    statusBadge.innerHTML = 'UNSOLVED';
    if (statusText) {
      statusText.innerHTML = 'Lab: JWT authentication bypass via jku header injection';
    }
  }
}

// Lightweight Confetti Animation
function triggerConfetti() {
  let canvas = document.getElementById('confetti-canvas');
  if (!canvas) {
    canvas = document.createElement('canvas');
    canvas.id = 'confetti-canvas';
    document.body.appendChild(canvas);
  }

  const ctx = canvas.getContext('2d');
  let width = (canvas.width = window.innerWidth);
  let height = (canvas.height = window.innerHeight);

  window.addEventListener('resize', () => {
    width = canvas.width = window.innerWidth;
    height = canvas.height = window.innerHeight;
  });

  const colors = ['#10b981', '#3b82f6', '#ff6633', '#f59e0b', '#ec4899', '#8b5cf6'];
  const particles = [];
  const particleCount = 120;

  for (let i = 0; i < particleCount; i++) {
    particles.push({
      x: Math.random() * width,
      y: Math.random() * height - height,
      size: Math.random() * 8 + 4,
      color: colors[Math.floor(Math.random() * colors.length)],
      rotation: Math.random() * 360,
      rotationSpeed: (Math.random() - 0.5) * 8,
      speedX: (Math.random() - 0.5) * 4,
      speedY: Math.random() * 3 + 3,
      opacity: 1
    });
  }

  let animationFrame;
  let startTime = Date.now();

  function render() {
    ctx.clearRect(0, 0, width, height);
    const elapsed = Date.now() - startTime;

    particles.forEach(p => {
      p.x += p.speedX;
      p.y += p.speedY;
      p.rotation += p.rotationSpeed;

      ctx.save();
      ctx.translate(p.x, p.y);
      ctx.rotate((p.rotation * Math.PI) / 180);
      ctx.fillStyle = p.color;
      ctx.fillRect(-p.size / 2, -p.size / 2, p.size, p.size);
      ctx.restore();
    });

    if (elapsed < 4500) {
      animationFrame = requestAnimationFrame(render);
    } else {
      ctx.clearRect(0, 0, width, height);
      if (canvas && canvas.parentNode) {
        canvas.parentNode.removeChild(canvas);
      }
    }
  }

  render();
}

// Initialize on DOM load
document.addEventListener('DOMContentLoaded', () => {
  // Start polling
  pollLabStatus();
  setInterval(pollLabStatus, 3000);
});
